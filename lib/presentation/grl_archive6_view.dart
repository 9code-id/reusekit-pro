import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArchive6View extends StatefulWidget {
  @override
  State<GrlArchive6View> createState() => _GrlArchive6ViewState();
}

class _GrlArchive6ViewState extends State<GrlArchive6View> with TickerProviderStateMixin {
  String searchQuery = "";
  String selectedView = "Grid";
  String sortBy = "Date";
  bool isAscending = false;
  
  List<Map<String, dynamic>> mediaFiles = [
    {
      "id": "IMG_001",
      "name": "Company Event 2024",
      "type": "image",
      "format": "JPG",
      "size": "2.4 MB",
      "date": "2024-12-15",
      "dimensions": "1920x1080",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=event",
      "tags": ["event", "company", "2024"],
      "folder": "Events",
      "resolution": "HD",
      "duration": null,
    },
    {
      "id": "VID_001",
      "name": "Product Demo Video",
      "type": "video",
      "format": "MP4",
      "size": "45.8 MB",
      "date": "2024-12-10",
      "dimensions": "1920x1080",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=product",
      "tags": ["demo", "product", "marketing"],
      "folder": "Marketing",
      "resolution": "Full HD",
      "duration": "3:45",
    },
    {
      "id": "IMG_002",
      "name": "Team Photo Session",
      "type": "image",
      "format": "PNG",
      "size": "8.2 MB",
      "date": "2024-12-08",
      "dimensions": "2560x1440",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=team",
      "tags": ["team", "photo", "portrait"],
      "folder": "HR",
      "resolution": "2K",
      "duration": null,
    },
    {
      "id": "AUD_001",
      "name": "Podcast Interview",
      "type": "audio",
      "format": "MP3",
      "size": "12.5 MB",
      "date": "2024-12-05",
      "dimensions": null,
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=podcast",
      "tags": ["podcast", "interview", "audio"],
      "folder": "Content",
      "resolution": "320kbps",
      "duration": "25:18",
    },
    {
      "id": "IMG_003",
      "name": "Office Interior Design",
      "type": "image",
      "format": "JPG",
      "size": "5.1 MB",
      "date": "2024-11-28",
      "dimensions": "4000x3000",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=office",
      "tags": ["office", "interior", "design"],
      "folder": "Facilities",
      "resolution": "4K",
      "duration": null,
    },
    {
      "id": "VID_002",
      "name": "Training Tutorial",
      "type": "video",
      "format": "MOV",
      "size": "128.3 MB",
      "date": "2024-11-25",
      "dimensions": "3840x2160",
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=training",
      "tags": ["training", "tutorial", "education"],
      "folder": "Training",
      "resolution": "4K",
      "duration": "12:30",
    },
  ];

  List<Map<String, dynamic>> viewOptions = [
    {"label": "Grid", "value": "Grid"},
    {"label": "List", "value": "List"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date", "value": "Date"},
    {"label": "Name", "value": "Name"},
    {"label": "Size", "value": "Size"},
    {"label": "Type", "value": "Type"},
  ];

  List<Map<String, dynamic>> get filteredAndSortedFiles {
    List<Map<String, dynamic>> filtered = mediaFiles.where((file) {
      if (searchQuery.isEmpty) return true;
      
      return file["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             file["folder"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             (file["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
    }).toList();

    filtered.sort((a, b) {
      int comparison = 0;
      
      switch (sortBy) {
        case "Date":
          comparison = DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"]));
          break;
        case "Name":
          comparison = a["name"].toString().compareTo(b["name"].toString());
          break;
        case "Size":
          comparison = _parseSize(a["size"]).compareTo(_parseSize(b["size"]));
          break;
        case "Type":
          comparison = a["type"].toString().compareTo(b["type"].toString());
          break;
      }

      return isAscending ? comparison : -comparison;
    });

    return filtered;
  }

  double _parseSize(String sizeStr) {
    double size = double.parse(sizeStr.replaceAll(RegExp(r'[^0-9.]'), ''));
    if (sizeStr.toUpperCase().contains('GB')) {
      size *= 1024;
    }
    return size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Archive"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search media files...",
                  value: searchQuery,
                  hint: "Search by name, folder, or tags",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "View",
                        items: viewOptions,
                        value: selectedView,
                        onChanged: (value, label) {
                          selectedView = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort by",
                        items: sortOptions,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        isAscending = !isAscending;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results Info
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredAndSortedFiles.length} files",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                if (searchQuery.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      searchQuery = "";
                      setState(() {});
                    },
                    child: Text(
                      "Clear search",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: selectedView == "Grid" ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 200,
        children: filteredAndSortedFiles.map((file) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              Stack(
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      image: DecorationImage(
                        image: NetworkImage("${file["thumbnail"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: spXs,
                    right: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getTypeColor(file["type"]).withAlpha(200),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${file["format"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (file["type"] == "video" || file["type"] == "audio")
                    Positioned(
                      bottom: spXs,
                      right: spXs,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${file["duration"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
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
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getTypeIcon(file["type"]),
                          color: _getTypeColor(file["type"]),
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${file["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${file["folder"]} • ${file["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    if (file["dimensions"] != null)
                      Text(
                        "${file["dimensions"]} • ${file["resolution"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                    SizedBox(height: spSm),
                    
                    // Tags
                    Wrap(
                      spacing: spXxs,
                      runSpacing: spXxs,
                      children: (file["tags"] as List).take(2).map((tag) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )).toList(),
                    ),
                    SizedBox(height: spSm),
                    
                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View",
                            size: bs.sm,
                            onPressed: () {
                              // Handle view
                            },
                          ),
                        ),
                        SizedBox(width: spXs),
                        GestureDetector(
                          onTap: () {
                            _showFileOptions(file);
                          },
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.more_vert,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredAndSortedFiles.length,
      itemBuilder: (context, index) {
        final file = filteredAndSortedFiles[index];
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              // Thumbnail
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${file["thumbnail"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: _getTypeColor(file["type"]).withAlpha(200),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          _getTypeIcon(file["type"]),
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              
              // File Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${file["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXxs),
                    Text(
                      "${file["folder"]} • ${file["format"]} • ${file["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXxs),
                    if (file["dimensions"] != null || file["duration"] != null)
                      Text(
                        "${file["dimensions"] ?? ""} ${file["duration"] != null ? "• ${file["duration"]}" : ""}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                  ],
                ),
              ),
              
              // Actions
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle download
                    },
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.download,
                        color: infoColor,
                        size: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  GestureDetector(
                    onTap: () {
                      _showFileOptions(file);
                    },
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "image":
        return Icons.image;
      case "video":
        return Icons.videocam;
      case "audio":
        return Icons.audiotrack;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "image":
        return successColor;
      case "video":
        return warningColor;
      case "audio":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterDialog() {
    // Show filter dialog
  }

  void _showFileOptions(Map<String, dynamic> file) {
    // Show file options dialog
  }
}
