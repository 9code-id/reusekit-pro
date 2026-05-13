import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaAlbumDetailView extends StatefulWidget {
  const PpaAlbumDetailView({super.key});

  @override
  State<PpaAlbumDetailView> createState() => _PpaAlbumDetailViewState();
}

class _PpaAlbumDetailViewState extends State<PpaAlbumDetailView> {
  Map<String, dynamic> albumInfo = {
    "id": 1,
    "name": "Nature & Travel",
    "description": "Beautiful nature photos and travel memories from around the world",
    "coverPhoto": "https://picsum.photos/400/300?random=1&keyword=nature",
    "dateCreated": "2024-01-15",
    "lastModified": "2024-03-15",
    "isPrivate": false,
    "photoCount": 45,
    "videoCount": 8,
    "totalSize": "456.7 MB",
    "shareCount": 12,
    "favoriteCount": 23,
  };

  List<Map<String, dynamic>> albumMedia = [
    {
      "id": 1,
      "url": "https://picsum.photos/300/400?random=1&keyword=mountain",
      "title": "Mountain Peak",
      "type": "photo",
      "date": "2024-03-15",
      "size": "4.2 MB",
      "resolution": "4032x3024",
      "favorite": true,
      "location": "Rocky Mountains"
    },
    {
      "id": 2,
      "url": "https://picsum.photos/300/200?random=2&keyword=lake",
      "title": "Serene Lake",
      "type": "video",
      "date": "2024-03-14",
      "size": "25.8 MB",
      "resolution": "1920x1080",
      "duration": "01:30",
      "favorite": false,
      "location": "Lake Tahoe"
    },
    {
      "id": 3,
      "url": "https://picsum.photos/300/400?random=3&keyword=forest",
      "title": "Forest Trail",
      "type": "photo",
      "date": "2024-03-13",
      "size": "3.9 MB",
      "resolution": "3024x4032",
      "favorite": true,
      "location": "Yellowstone"
    },
    {
      "id": 4,
      "url": "https://picsum.photos/300/400?random=4&keyword=sunset",
      "title": "Golden Sunset",
      "type": "photo",
      "date": "2024-03-12",
      "size": "5.1 MB",
      "resolution": "4032x3024",
      "favorite": false,
      "location": "Grand Canyon"
    },
    {
      "id": 5,
      "url": "https://picsum.photos/300/200?random=5&keyword=wildlife",
      "title": "Wildlife Video",
      "type": "video",
      "date": "2024-03-11",
      "size": "38.4 MB",
      "resolution": "4K",
      "duration": "02:45",
      "favorite": true,
      "location": "Safari Park"
    },
    {
      "id": 6,
      "url": "https://picsum.photos/300/400?random=6&keyword=beach",
      "title": "Ocean Waves",
      "type": "photo",
      "date": "2024-03-10",
      "size": "4.7 MB",
      "resolution": "4032x3024",
      "favorite": false,
      "location": "Malibu Beach"
    },
    {
      "id": 7,
      "url": "https://picsum.photos/300/400?random=7&keyword=snow",
      "title": "Snow Mountains",
      "type": "photo",
      "date": "2024-03-09",
      "size": "6.2 MB",
      "resolution": "4032x3024",
      "favorite": true,
      "location": "Swiss Alps"
    },
    {
      "id": 8,
      "url": "https://picsum.photos/300/400?random=8&keyword=desert",
      "title": "Desert Landscape",
      "type": "photo",
      "date": "2024-03-08",
      "size": "3.8 MB",
      "resolution": "3024x4032",
      "favorite": false,
      "location": "Death Valley"
    },
  ];

  List<Map<String, dynamic>> filteredMedia = [];
  String selectedType = "All";
  String searchQuery = "";
  bool showFavoritesOnly = false;
  bool isSelectMode = false;
  List<int> selectedItems = [];
  bool isGridView = true;

  @override
  void initState() {
    super.initState();
    filteredMedia = albumMedia;
  }

  void _filterMedia() {
    filteredMedia = albumMedia.where((media) {
      bool matchesType = selectedType == "All" || media["type"] == selectedType;
      bool matchesFavorite = !showFavoritesOnly || (media["favorite"] as bool);
      bool matchesSearch = searchQuery.isEmpty ||
          "${media["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${media["location"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesType && matchesFavorite && matchesSearch;
    }).toList();
    setState(() {});
  }

  void _toggleSelectMode() {
    isSelectMode = !isSelectMode;
    if (!isSelectMode) {
      selectedItems.clear();
    }
    setState(() {});
  }

  void _toggleItemSelection(int itemId) {
    if (selectedItems.contains(itemId)) {
      selectedItems.remove(itemId);
    } else {
      selectedItems.add(itemId);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectMode ? "${selectedItems.length} Selected" : "${albumInfo["name"]}"),
        actions: [
          if (!isSelectMode) ...[
            IconButton(
              icon: Icon(isGridView ? Icons.view_list : Icons.view_module),
              onPressed: () {
                isGridView = !isGridView;
                setState(() {});
              },
            ),
            IconButton(
              icon: Icon(Icons.select_all),
              onPressed: _toggleSelectMode,
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                ss("Add photos to album");
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                ss("Album options");
              },
            ),
          ] else ...[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: _toggleSelectMode,
            ),
            if (selectedItems.isNotEmpty) ...[
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  ss("Sharing ${selectedItems.length} items");
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  bool isConfirmed = await confirm("Remove ${selectedItems.length} items from album?");
                  if (isConfirmed) {
                    ss("Removed ${selectedItems.length} items from album");
                    _toggleSelectMode();
                  }
                },
              ),
            ],
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Album Header Info
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
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${albumInfo["coverPhoto"]}",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${albumInfo["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if (albumInfo["isPrivate"] as bool)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: dangerColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.lock,
                                          size: 12,
                                          color: dangerColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "Private",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: dangerColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${albumInfo["description"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Created: ${DateTime.parse(albumInfo["dateCreated"]).dMMMy}",
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
                              Text(
                                "${albumInfo["photoCount"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Photos",
                                style: TextStyle(
                                  fontSize: 11,
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
                              Text(
                                "${albumInfo["videoCount"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Videos",
                                style: TextStyle(
                                  fontSize: 11,
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
                              Text(
                                "${albumInfo["favoriteCount"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Favorites",
                                style: TextStyle(
                                  fontSize: 11,
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
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${albumInfo["totalSize"]}".replaceAll(" MB", ""),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "MB",
                                style: TextStyle(
                                  fontSize: 11,
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
                          label: "Search in album...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            _filterMedia();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: _filterMedia,
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
                            {"label": "All Media", "value": "All"},
                            {"label": "Photos", "value": "photo"},
                            {"label": "Videos", "value": "video"},
                          ],
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            _filterMedia();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Favorites Only",
                              "value": true,
                              "checked": showFavoritesOnly,
                            }
                          ],
                          value: [
                            if (showFavoritesOnly)
                              {
                                "label": "Favorites Only",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showFavoritesOnly = values.isNotEmpty;
                            _filterMedia();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Media Grid/List
            if (isGridView)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredMedia.map((media) {
                  bool isSelected = selectedItems.contains(media["id"] as int);
                  bool isVideo = media["type"] == "video";
                  
                  return GestureDetector(
                    onTap: () {
                      if (isSelectMode) {
                        _toggleItemSelection(media["id"] as int);
                      } else {
                        ss("Opening ${isVideo ? 'video' : 'photo'}: ${media["title"]}");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: isSelected ? Border.all(color: primaryColor, width: 3) : null,
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
                                  "${media["url"]}",
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                if (isSelectMode)
                                  Positioned(
                                    top: spXs,
                                    right: spXs,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSelected ? primaryColor : Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected ? primaryColor : disabledBoldColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: isSelected ? Colors.white : Colors.transparent,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                if (media["favorite"] as bool)
                                  Positioned(
                                    top: spXs,
                                    left: spXs,
                                    child: Icon(
                                      Icons.favorite,
                                      color: dangerColor,
                                      size: 20,
                                    ),
                                  ),
                                if (isVideo) ...[
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
                                        "${media["duration"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${media["title"]}",
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
                                        "${media["location"]}",
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
                                    Text(
                                      "${media["resolution"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${media["size"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${DateTime.parse(media["date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 11,
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
                }).toList(),
              )
            else
              Column(
                children: filteredMedia.map((media) {
                  bool isSelected = selectedItems.contains(media["id"] as int);
                  bool isVideo = media["type"] == "video";
                  
                  return GestureDetector(
                    onTap: () {
                      if (isSelectMode) {
                        _toggleItemSelection(media["id"] as int);
                      } else {
                        ss("Opening ${isVideo ? 'video' : 'photo'}: ${media["title"]}");
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: isSelected ? Border.all(color: primaryColor, width: 3) : null,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Stack(
                              children: [
                                Image.network(
                                  "${media["url"]}",
                                  width: 100,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                if (isVideo)
                                  Positioned.fill(
                                    child: Container(
                                      color: Colors.black.withAlpha(100),
                                      child: Icon(
                                        Icons.play_circle_filled,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                if (isSelectMode)
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSelected ? primaryColor : Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected ? primaryColor : disabledBoldColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: isSelected ? Colors.white : Colors.transparent,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${media["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    if (media["favorite"] as bool)
                                      Icon(
                                        Icons.favorite,
                                        color: dangerColor,
                                        size: 18,
                                      ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${media["location"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${media["resolution"]} • ${media["size"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${DateTime.parse(media["date"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                if (isVideo)
                                  Text(
                                    "Duration: ${media["duration"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

            SizedBox(height: spMd),

            // Album Actions
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
                    "Album Actions",
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
                          label: "Add Photos",
                          icon: Icons.add_photo_alternate,
                          size: bs.md,
                          onPressed: () {
                            ss("Add photos to album");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Share Album",
                          icon: Icons.share,
                          size: bs.md,
                          onPressed: () {
                            ss("Share album: ${albumInfo["name"]}");
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
