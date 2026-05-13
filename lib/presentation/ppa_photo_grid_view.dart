import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaPhotoGridView extends StatefulWidget {
  const PpaPhotoGridView({super.key});

  @override
  State<PpaPhotoGridView> createState() => _PpaPhotoGridViewState();
}

class _PpaPhotoGridViewState extends State<PpaPhotoGridView> {
  List<String> selectedPhotos = [];
  int gridColumns = 3;
  String sortBy = "date";
  String filterBy = "all";
  bool isSelectMode = false;

  final List<Map<String, dynamic>> photos = List.generate(50, (index) => {
    "id": "photo_$index",
    "url": "https://picsum.photos/300/300?random=$index",
    "title": "Photo ${index + 1}",
    "date": DateTime.now().subtract(Duration(days: index)),
    "size": "${(index % 5 + 1) * 0.5}MB",
    "dimension": "${300 + (index % 200)}x${300 + (index % 200)}",
    "type": index % 4 == 0 ? "portrait" : index % 4 == 1 ? "landscape" : index % 4 == 2 ? "square" : "panorama",
    "favorite": index % 7 == 0,
  });

  final List<Map<String, dynamic>> sortOptions = [
    {"label": "Date Added", "value": "date"},
    {"label": "Name", "value": "name"},
    {"label": "Size", "value": "size"},
    {"label": "Favorites", "value": "favorite"},
  ];

  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All Photos", "value": "all"},
    {"label": "Portraits", "value": "portrait"},
    {"label": "Landscapes", "value": "landscape"},
    {"label": "Square", "value": "square"},
    {"label": "Panorama", "value": "panorama"},
    {"label": "Favorites", "value": "favorite"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectMode ? "${selectedPhotos.length} Selected" : "Photo Grid"),
        actions: [
          if (isSelectMode) ...[
            QButton(
              icon: Icons.delete,
              size: bs.sm,
              onPressed: () {
                _deleteSelectedPhotos();
              },
            ),
            QButton(
              icon: Icons.share,
              size: bs.sm,
              onPressed: () {
                _shareSelectedPhotos();
              },
            ),
            QButton(
              icon: Icons.close,
              size: bs.sm,
              onPressed: () {
                isSelectMode = false;
                selectedPhotos.clear();
                setState(() {});
              },
            ),
          ] else ...[
            QButton(
              icon: Icons.view_module,
              size: bs.sm,
              onPressed: () {
                _showGridOptions();
              },
            ),
            QButton(
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                _addPhotos();
              },
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Filter and Sort Bar
          Container(
            padding: EdgeInsets.all(spSm),
            color: Colors.grey[50],
            child: Row(
              spacing: spSm,
              children: [
                // Filter Dropdown
                Expanded(
                  child: QDropdownField(
                    label: "Filter",
                    items: filterOptions,
                    value: filterBy,
                    onChanged: (value, label) {
                      filterBy = value;
                      setState(() {});
                    },
                  ),
                ),
                // Sort Dropdown
                Expanded(
                  child: QDropdownField(
                    label: "Sort",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
                // Select Mode Toggle
                QButton(
                  icon: Icons.check_circle,
                  size: bs.sm,
                  onPressed: () {
                    isSelectMode = !isSelectMode;
                    if (!isSelectMode) {
                      selectedPhotos.clear();
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Photo Grid
          Expanded(
            child: _buildPhotoGrid(),
          ),

          // Bottom Actions (when in select mode)
          if (isSelectMode && selectedPhotos.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Select All",
                      size: bs.sm,
                      onPressed: () {
                        if (selectedPhotos.length == _getFilteredPhotos().length) {
                          selectedPhotos.clear();
                        } else {
                          selectedPhotos = _getFilteredPhotos().map((photo) => photo["id"] as String).toList();
                        }
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Create Collage",
                      size: bs.sm,
                      onPressed: () {
                        _createCollage();
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Add to Album",
                      size: bs.sm,
                      onPressed: () {
                        _addToAlbum();
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPhotoGrid() {
    final filteredPhotos = _getFilteredPhotos();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spSm),
      child: ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 120,
        children: filteredPhotos.map((photo) {
          final isSelected = selectedPhotos.contains(photo["id"]);
          
          return GestureDetector(
            onTap: () {
              if (isSelectMode) {
                if (isSelected) {
                  selectedPhotos.remove(photo["id"]);
                } else {
                  selectedPhotos.add(photo["id"] as String);
                }
                setState(() {});
              } else {
                _openPhotoDetail(photo);
              }
            },
            onLongPress: () {
              if (!isSelectMode) {
                isSelectMode = true;
                selectedPhotos.add(photo["id"] as String);
                setState(() {});
              }
            },
            child: Stack(
              children: [
                // Photo Container
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.network(
                        "${photo["url"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // Selection Overlay
                if (isSelectMode)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(128) : Colors.black.withAlpha(64),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.transparent,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),

                // Favorite Icon
                if (photo["favorite"] as bool)
                  Positioned(
                    top: spXs,
                    right: spXs,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(128),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 16,
                      ),
                    ),
                  ),

                // Photo Info
                if (!isSelectMode)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(180),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radiusSm),
                          bottomRight: Radius.circular(radiusSm),
                        ),
                      ),
                      child: Column(
                        spacing: 2,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${photo["title"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${photo["dimension"]} • ${photo["size"]}",
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white70,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredPhotos() {
    List<Map<String, dynamic>> filtered = photos;

    // Apply filter
    if (filterBy != "all") {
      if (filterBy == "favorite") {
        filtered = filtered.where((photo) => photo["favorite"] as bool).toList();
      } else {
        filtered = filtered.where((photo) => photo["type"] == filterBy).toList();
      }
    }

    // Apply sort
    switch (sortBy) {
      case "date":
        filtered.sort((a, b) => (b["date"] as DateTime).compareTo(a["date"] as DateTime));
        break;
      case "name":
        filtered.sort((a, b) => (a["title"] as String).compareTo(b["title"] as String));
        break;
      case "size":
        filtered.sort((a, b) => (b["size"] as String).compareTo(a["size"] as String));
        break;
      case "favorite":
        filtered.sort((a, b) => (b["favorite"] as bool ? 1 : 0).compareTo(a["favorite"] as bool ? 1 : 0));
        break;
    }

    return filtered;
  }

  void _showGridOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Grid Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Row(
              spacing: spSm,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [2, 3, 4, 5].map((columns) {
                final isSelected = gridColumns == columns;
                return GestureDetector(
                  onTap: () {
                    gridColumns = columns;
                    setState(() {});
                    back();
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.grid_view,
                          color: isSelected ? Colors.white : primaryColor,
                          size: 24,
                        ),
                        Text(
                          "${columns}x",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _addPhotos() {
    ss("Add photos functionality");
  }

  void _deleteSelectedPhotos() async {
    bool isConfirmed = await confirm("Delete ${selectedPhotos.length} selected photos?");
    if (isConfirmed) {
      selectedPhotos.clear();
      isSelectMode = false;
      setState(() {});
      ss("Selected photos deleted");
    }
  }

  void _shareSelectedPhotos() {
    ss("Sharing ${selectedPhotos.length} photos");
  }

  void _createCollage() {
    if (selectedPhotos.length < 2) {
      se("Select at least 2 photos to create a collage");
      return;
    }
    ss("Creating collage with ${selectedPhotos.length} photos");
  }

  void _addToAlbum() {
    ss("Adding ${selectedPhotos.length} photos to album");
  }

  void _openPhotoDetail(Map<String, dynamic> photo) {
    ss("Opening ${photo["title"]}");
  }
}
