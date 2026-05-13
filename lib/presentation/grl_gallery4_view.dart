import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlGallery4View extends StatefulWidget {
  @override
  State<GrlGallery4View> createState() => _GrlGallery4ViewState();
}

class _GrlGallery4ViewState extends State<GrlGallery4View> {
  String selectedSortBy = "Recent";
  String selectedFilter = "All";
  bool loading = false;

  final List<Map<String, dynamic>> sortOptions = [
    {"label": "Recent", "value": "Recent"},
    {"label": "Popular", "value": "Popular"},
    {"label": "Name A-Z", "value": "Name A-Z"},
    {"label": "Date", "value": "Date"},
  ];

  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Landscape", "value": "Landscape"},
    {"label": "Portrait", "value": "Portrait"},
    {"label": "Square", "value": "Square"},
  ];

  final List<Map<String, dynamic>> photos = [
    {
      "id": 1,
      "title": "Sunrise Valley",
      "url": "https://picsum.photos/400/600?random=50&keyword=landscape",
      "type": "Landscape",
      "size": "4.2 MB",
      "resolution": "1920x1080",
      "date": "2024-01-20",
      "camera": "Canon EOS R5",
      "iso": 100,
      "aperture": "f/8",
      "shutter": "1/125s",
      "selected": false
    },
    {
      "id": 2,
      "title": "City Portrait",
      "url": "https://picsum.photos/300/400?random=51&keyword=portrait",
      "type": "Portrait",
      "size": "3.8 MB",
      "resolution": "1080x1920",
      "date": "2024-01-19",
      "camera": "Sony A7R IV",
      "iso": 200,
      "aperture": "f/4",
      "shutter": "1/60s",
      "selected": false
    },
    {
      "id": 3,
      "title": "Perfect Square",
      "url": "https://picsum.photos/400/400?random=52&keyword=square",
      "type": "Square",
      "size": "2.9 MB",
      "resolution": "1080x1080",
      "date": "2024-01-18",
      "camera": "Fujifilm X-T4",
      "iso": 400,
      "aperture": "f/5.6",
      "shutter": "1/250s",
      "selected": false
    },
    {
      "id": 4,
      "title": "Ocean Horizon",
      "url": "https://picsum.photos/400/600?random=53&keyword=ocean",
      "type": "Landscape",
      "size": "5.1 MB",
      "resolution": "2560x1440",
      "date": "2024-01-17",
      "camera": "Nikon D850",
      "iso": 64,
      "aperture": "f/11",
      "shutter": "1/200s",
      "selected": false
    },
    {
      "id": 5,
      "title": "Street Style",
      "url": "https://picsum.photos/300/400?random=54&keyword=street",
      "type": "Portrait",
      "size": "4.7 MB",
      "resolution": "1200x1600",
      "date": "2024-01-16",
      "camera": "Leica Q2",
      "iso": 800,
      "aperture": "f/2.8",
      "shutter": "1/30s",
      "selected": false
    },
    {
      "id": 6,
      "title": "Minimal Art",
      "url": "https://picsum.photos/400/400?random=55&keyword=minimal",
      "type": "Square",
      "size": "1.8 MB",
      "resolution": "800x800",
      "date": "2024-01-15",
      "camera": "iPhone 15 Pro",
      "iso": 50,
      "aperture": "f/1.8",
      "shutter": "1/500s",
      "selected": false
    },
  ];

  List<Map<String, dynamic>> get filteredPhotos {
    var filtered = photos.where((photo) {
      if (selectedFilter == "All") return true;
      return photo["type"] == selectedFilter;
    }).toList();

    // Sort photos
    switch (selectedSortBy) {
      case "Popular":
        filtered.sort((a, b) => (b["id"] as int).compareTo(a["id"] as int));
        break;
      case "Name A-Z":
        filtered.sort((a, b) => (a["title"] as String).compareTo(b["title"] as String));
        break;
      case "Date":
        filtered.sort((a, b) => (b["date"] as String).compareTo(a["date"] as String));
        break;
      default: // Recent
        break;
    }

    return filtered;
  }

  List<Map<String, dynamic>> get selectedPhotos {
    return photos.where((photo) => photo["selected"] == true).toList();
  }

  void _toggleSelection(int photoId) {
    final photoIndex = photos.indexWhere((photo) => photo["id"] == photoId);
    if (photoIndex != -1) {
      photos[photoIndex]["selected"] = !(photos[photoIndex]["selected"] as bool);
      setState(() {});
    }
  }

  void _selectAll() {
    for (var photo in photos) {
      photo["selected"] = true;
    }
    setState(() {});
  }

  void _clearSelection() {
    for (var photo in photos) {
      photo["selected"] = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Library"),
        actions: [
          if (selectedPhotos.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                bool isConfirmed = await confirm("Delete ${selectedPhotos.length} selected photos?");
                if (isConfirmed) {
                  _clearSelection();
                  ss("Photos deleted successfully!");
                }
              },
            ),
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () {
              si("Upload feature coming soon!");
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
                  // Header Stats
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${photos.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Photos",
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
                                "${selectedPhotos.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Selected",
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
                                "${(photos.fold(0.0, (sum, photo) => sum + double.parse(photo["size"].toString().replaceAll(" MB", "")))).toStringAsFixed(1)} MB",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                      ],
                    ),
                  ),

                  // Filters and Sort
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortOptions,
                          value: selectedSortBy,
                          onChanged: (value, label) {
                            selectedSortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Filter",
                          items: filterOptions,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Selection Actions
                  if (selectedPhotos.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: successColor.withAlpha(30)),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle, color: successColor, size: 20),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${selectedPhotos.length} photos selected",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: _clearSelection,
                                child: Text(
                                  "Clear",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Download",
                                  icon: Icons.download,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Download started!");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Share",
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Share feature coming soon!");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  // Quick Actions
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Select All",
                          size: bs.sm,
                          onPressed: _selectAll,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Clear All",
                          size: bs.sm,
                          onPressed: _clearSelection,
                        ),
                      ),
                    ],
                  ),

                  // Photos Grid
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: filteredPhotos.map((photo) {
                      final isSelected = photo["selected"] as bool;
                      return GestureDetector(
                        onTap: () => _toggleSelection(photo["id"] as int),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledColor,
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: isSelected ? [shadowMd] : [shadowSm],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Stack(
                              children: [
                                // Image
                                Image.network(
                                  "${photo["url"]}",
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),

                                // Selection Overlay
                                if (isSelected)
                                  Positioned.fill(
                                    child: Container(
                                      color: primaryColor.withAlpha(50),
                                    ),
                                  ),

                                // Selection Checkbox
                                Positioned(
                                  top: spSm,
                                  right: spSm,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: isSelected ? primaryColor : Colors.white,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      border: Border.all(
                                        color: isSelected ? primaryColor : disabledColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: isSelected
                                        ? Icon(
                                            Icons.check,
                                            size: 16,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                ),

                                // Photo Info
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withAlpha(180),
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      spacing: spXs,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${photo["title"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${photo["resolution"]}",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "${photo["size"]}",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Type Badge
                                Positioned(
                                  top: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getTypeColor(photo["type"] as String).withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${photo["type"]}",
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
                      );
                    }).toList(),
                  ),

                  // Load More
                  Center(
                    child: QButton(
                      label: "Load More Photos",
                      size: bs.md,
                      onPressed: () async {
                        loading = true;
                        setState(() {});
                        
                        await Future.delayed(Duration(seconds: 2));
                        
                        loading = false;
                        setState(() {});
                        
                        si("More photos loaded!");
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Landscape":
        return successColor;
      case "Portrait":
        return primaryColor;
      case "Square":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}
