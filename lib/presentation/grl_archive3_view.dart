import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArchive3View extends StatefulWidget {
  @override
  State<GrlArchive3View> createState() => _GrlArchive3ViewState();
}

class _GrlArchive3ViewState extends State<GrlArchive3View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedSort = "Recent";
  bool isGridView = true;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Images", "value": "Images"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Audio", "value": "Audio"},
    {"label": "Projects", "value": "Projects"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recent", "value": "Recent"},
    {"label": "Oldest", "value": "Oldest"},
    {"label": "Name A-Z", "value": "Name A-Z"},
    {"label": "Name Z-A", "value": "Name Z-A"},
    {"label": "Size Large", "value": "Size Large"},
    {"label": "Size Small", "value": "Size Small"},
  ];

  List<Map<String, dynamic>> archiveItems = [
    {
      "id": 1,
      "name": "Project Documentation.pdf",
      "type": "Documents",
      "size": 2.4,
      "date": "2024-03-15",
      "thumbnail": "https://picsum.photos/150/150?random=1&keyword=document",
      "tags": ["Important", "Work"],
      "downloadCount": 45,
    },
    {
      "id": 2,
      "name": "Team Meeting Recording.mp4",
      "type": "Videos",
      "size": 124.7,
      "date": "2024-03-14",
      "thumbnail": "https://picsum.photos/150/150?random=2&keyword=video",
      "tags": ["Meeting", "Team"],
      "downloadCount": 23,
    },
    {
      "id": 3,
      "name": "Design Assets Pack.zip",
      "type": "Projects",
      "size": 67.3,
      "date": "2024-03-13",
      "thumbnail": "https://picsum.photos/150/150?random=3&keyword=design",
      "tags": ["Design", "Assets"],
      "downloadCount": 89,
    },
    {
      "id": 4,
      "name": "Conference Presentation.pptx",
      "type": "Documents",
      "size": 15.8,
      "date": "2024-03-12",
      "thumbnail": "https://picsum.photos/150/150?random=4&keyword=presentation",
      "tags": ["Presentation", "Conference"],
      "downloadCount": 67,
    },
    {
      "id": 5,
      "name": "Product Photos Collection.zip",
      "type": "Images",
      "size": 234.1,
      "date": "2024-03-11",
      "thumbnail": "https://picsum.photos/150/150?random=5&keyword=photos",
      "tags": ["Photos", "Product"],
      "downloadCount": 156,
    },
    {
      "id": 6,
      "name": "Podcast Episode 12.mp3",
      "type": "Audio",
      "size": 45.6,
      "date": "2024-03-10",
      "thumbnail": "https://picsum.photos/150/150?random=6&keyword=audio",
      "tags": ["Podcast", "Audio"],
      "downloadCount": 78,
    },
    {
      "id": 7,
      "name": "Website Backup 2024.zip",
      "type": "Projects",
      "size": 512.3,
      "date": "2024-03-09",
      "thumbnail": "https://picsum.photos/150/150?random=7&keyword=backup",
      "tags": ["Backup", "Website"],
      "downloadCount": 34,
    },
    {
      "id": 8,
      "name": "Training Materials.pdf",
      "type": "Documents",
      "size": 89.4,
      "date": "2024-03-08",
      "thumbnail": "https://picsum.photos/150/150?random=8&keyword=training",
      "tags": ["Training", "Education"],
      "downloadCount": 123,
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> filtered = archiveItems;

    if (selectedCategory != "All") {
      filtered = filtered.where((item) => item["type"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) => 
        (item["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        ((item["tags"] as List).any((tag) => 
          (tag as String).toLowerCase().contains(searchQuery.toLowerCase())))
      ).toList();
    }

    // Sort items
    switch (selectedSort) {
      case "Recent":
        filtered.sort((a, b) => (b["date"] as String).compareTo(a["date"] as String));
        break;
      case "Oldest":
        filtered.sort((a, b) => (a["date"] as String).compareTo(b["date"] as String));
        break;
      case "Name A-Z":
        filtered.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
        break;
      case "Name Z-A":
        filtered.sort((a, b) => (b["name"] as String).compareTo(a["name"] as String));
        break;
      case "Size Large":
        filtered.sort((a, b) => (b["size"] as double).compareTo(a["size"] as double));
        break;
      case "Size Small":
        filtered.sort((a, b) => (a["size"] as double).compareTo(b["size"] as double));
        break;
    }

    return filtered;
  }

  String _formatFileSize(double sizeInMB) {
    if (sizeInMB >= 1024) {
      return "${(sizeInMB / 1024).toStringAsFixed(1)} GB";
    }
    return "${sizeInMB.toStringAsFixed(1)} MB";
  }

  IconData _getFileTypeIcon(String type) {
    switch (type) {
      case "Documents":
        return Icons.description;
      case "Images":
        return Icons.image;
      case "Videos":
        return Icons.videocam;
      case "Audio":
        return Icons.audiotrack;
      case "Projects":
        return Icons.folder;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getFileTypeColor(String type) {
    switch (type) {
      case "Documents":
        return Colors.blue;
      case "Images":
        return Colors.green;
      case "Videos":
        return Colors.red;
      case "Audio":
        return Colors.orange;
      case "Projects":
        return Colors.purple;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildGridItem(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
              image: DecorationImage(
                image: NetworkImage("${item["thumbnail"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(100),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: spXs,
                    right: spXs,
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: _getFileTypeColor(item["type"] as String),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getFileTypeIcon(item["type"] as String),
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: spXs,
                    right: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        _formatFileSize(item["size"] as double),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  
                  Text(
                    "${item["date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  
                  // Tags
                  Wrap(
                    spacing: spXs,
                    children: ((item["tags"] as List).take(2)).map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$tag",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  Spacer(),
                  
                  // Stats and actions
                  Row(
                    children: [
                      Icon(
                        Icons.download,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${item["downloadCount"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.more_vert,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(Map<String, dynamic> item) {
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
                image: NetworkImage("${item["thumbnail"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusSm),
                color: Colors.black.withAlpha(100),
              ),
              child: Center(
                child: Icon(
                  _getFileTypeIcon(item["type"] as String),
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getFileTypeColor(item["type"] as String).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["type"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: _getFileTypeColor(item["type"] as String),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "•",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      _formatFileSize(item["size"] as double),
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Text(
                      "${item["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.download,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${item["downloadCount"]} downloads",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Actions
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                Icons.download,
                color: primaryColor,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: spXs),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.more_vert,
              color: disabledBoldColor,
              size: 20,
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
        title: Text("Archive"),
        actions: [
          GestureDetector(
            onTap: () {
              isGridView = !isGridView;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spXs),
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                isGridView ? Icons.list : Icons.grid_view,
                color: primaryColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Search bar
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search files...",
                          value: searchQuery,
                          hint: "Search by name or tags",
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // Filters
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
                          label: "Sort by",
                          items: sortOptions,
                          value: selectedSort,
                          onChanged: (value, label) {
                            selectedSort = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Stats summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Files",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${filteredItems.length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Size",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          _formatFileSize(
                            filteredItems.fold(0.0, (sum, item) => 
                              sum + (item["size"] as double))
                          ),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Downloads",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${filteredItems.fold(0, (sum, item) => sum + (item["downloadCount"] as int))}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Results header
            Row(
              children: [
                Text(
                  "Files (${filteredItems.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  isGridView ? "Grid View" : "List View",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            // File list/grid
            if (filteredItems.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No files found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else if (isGridView)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredItems.map((item) {
                  return _buildGridItem(item);
                }).toList(),
              )
            else
              Column(
                children: filteredItems.map((item) {
                  return _buildListItem(item);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
