import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStorage9View extends StatefulWidget {
  @override
  State<GrlStorage9View> createState() => _GrlStorage9ViewState();
}

class _GrlStorage9ViewState extends State<GrlStorage9View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Name";

  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All", "value": "All"},
    {"label": "Images", "value": "Images"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Audio", "value": "Audio"},
    {"label": "Archives", "value": "Archives"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "Name"},
    {"label": "Size", "value": "Size"},
    {"label": "Date", "value": "Date"},
    {"label": "Type", "value": "Type"},
  ];

  List<Map<String, dynamic>> allFiles = [
    {
      "name": "vacation_2024.jpg",
      "path": "/DCIM/Camera/",
      "fullPath": "/DCIM/Camera/vacation_2024.jpg",
      "size": 4.2,
      "unit": "MB",
      "type": "Images",
      "extension": "JPG",
      "dateModified": "2025-06-20 14:30",
      "isSelected": false,
      "icon": Icons.image,
      "color": successColor
    },
    {
      "name": "presentation.pptx",
      "path": "/Documents/Work/",
      "fullPath": "/Documents/Work/presentation.pptx",
      "size": 12.8,
      "unit": "MB",
      "type": "Documents",
      "extension": "PPTX",
      "dateModified": "2025-06-19 09:15",
      "isSelected": false,
      "icon": Icons.slideshow,
      "color": primaryColor
    },
    {
      "name": "workout_video.mp4",
      "path": "/Videos/Fitness/",
      "fullPath": "/Videos/Fitness/workout_video.mp4",
      "size": 89.5,
      "unit": "MB",
      "type": "Videos",
      "extension": "MP4",
      "dateModified": "2025-06-18 19:45",
      "isSelected": false,
      "icon": Icons.video_file,
      "color": dangerColor
    },
    {
      "name": "favorite_song.mp3",
      "path": "/Music/Playlists/",
      "fullPath": "/Music/Playlists/favorite_song.mp3",
      "size": 5.2,
      "unit": "MB",
      "type": "Audio",
      "extension": "MP3",
      "dateModified": "2025-06-17 16:20",
      "isSelected": false,
      "icon": Icons.audio_file,
      "color": infoColor
    },
    {
      "name": "backup_files.zip",
      "path": "/Downloads/",
      "fullPath": "/Downloads/backup_files.zip",
      "size": 234.7,
      "unit": "MB",
      "type": "Archives",
      "extension": "ZIP",
      "dateModified": "2025-06-16 11:30",
      "isSelected": false,
      "icon": Icons.archive,
      "color": warningColor
    },
    {
      "name": "recipe_book.pdf",
      "path": "/Documents/Personal/",
      "fullPath": "/Documents/Personal/recipe_book.pdf",
      "size": 2.1,
      "unit": "MB",
      "type": "Documents",
      "extension": "PDF",
      "dateModified": "2025-06-15 13:45",
      "isSelected": false,
      "icon": Icons.picture_as_pdf,
      "color": primaryColor
    },
    {
      "name": "family_portrait.png",
      "path": "/Pictures/Family/",
      "fullPath": "/Pictures/Family/family_portrait.png",
      "size": 8.9,
      "unit": "MB",
      "type": "Images",
      "extension": "PNG",
      "dateModified": "2025-06-14 10:15",
      "isSelected": false,
      "icon": Icons.image,
      "color": successColor
    },
    {
      "name": "project_demo.mov",
      "path": "/Videos/Projects/",
      "fullPath": "/Videos/Projects/project_demo.mov",
      "size": 156.3,
      "unit": "MB",
      "type": "Videos",
      "extension": "MOV",
      "dateModified": "2025-06-13 08:30",
      "isSelected": false,
      "icon": Icons.video_file,
      "color": dangerColor
    }
  ];

  bool selectAllMode = false;
  bool showThumbnails = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Manager"),
        actions: [
          IconButton(
            icon: Icon(showThumbnails ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              showThumbnails = !showThumbnails;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMoreOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildFileStats(),
          Expanded(
            child: _buildFileList(),
          ),
          if (_hasSelectedFiles()) _buildSelectionActions(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search files...",
                  value: searchQuery,
                  hint: "Enter filename or extension",
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
                onPressed: () {
                  si("Searching for: $searchQuery");
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryFilters,
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
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFileStats() {
    List<Map<String, dynamic>> filteredFiles = _getFilteredFiles();
    double totalSize = filteredFiles.fold(0.0, (sum, file) {
      double size = file["size"] as double;
      if (file["unit"] == "GB") size *= 1024;
      return sum + size;
    });

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.folder,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Text(
            "${filteredFiles.length} files",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Spacer(),
          Text(
            "${totalSize > 1024 ? (totalSize / 1024).toStringAsFixed(1) + ' GB' : totalSize.toStringAsFixed(1) + ' MB'}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
          GestureDetector(
            onTap: () {
              selectAllMode = !selectAllMode;
              for (var file in allFiles) {
                file["isSelected"] = selectAllMode;
              }
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: selectAllMode ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor),
              ),
              child: Text(
                selectAllMode ? "Deselect All" : "Select All",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: selectAllMode ? Colors.white : primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileList() {
    List<Map<String, dynamic>> filteredFiles = _getFilteredFiles();

    if (filteredFiles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No files found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your search criteria",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredFiles.length,
      itemBuilder: (context, index) {
        return _buildFileItem(filteredFiles[index]);
      },
    );
  }

  Widget _buildFileItem(Map<String, dynamic> file) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: file["isSelected"] ? primaryColor.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: file["isSelected"] 
            ? Border.all(color: primaryColor, width: 2)
            : null,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              file["isSelected"] = !file["isSelected"];
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: file["isSelected"] ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(
                  color: file["isSelected"] ? primaryColor : disabledOutlineBorderColor,
                ),
              ),
              child: Icon(
                file["isSelected"] ? Icons.check : null,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (file["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              file["icon"] as IconData,
              color: file["color"] as Color,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${file["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${file["path"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
                      decoration: BoxDecoration(
                        color: (file["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${file["extension"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: file["color"] as Color,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${file["dateModified"]}",
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${file["size"]} ${file["unit"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: file["color"] as Color,
                ),
              ),
              SizedBox(height: spXs),
              GestureDetector(
                onTap: () {
                  _showFileOptions(file);
                },
                child: Icon(
                  Icons.more_vert,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionActions() {
    int selectedCount = allFiles.where((file) => file["isSelected"]).length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
        border: Border(
          top: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "$selectedCount files selected",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  for (var file in allFiles) {
                    file["isSelected"] = false;
                  }
                  setState(() {});
                },
                child: Text(
                  "Clear",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: dangerColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Share",
                  icon: Icons.share,
                  size: bs.sm,
                  onPressed: () {
                    _shareSelectedFiles();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Move",
                  icon: Icons.drive_file_move,
                  size: bs.sm,
                  onPressed: () {
                    _moveSelectedFiles();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Delete",
                  icon: Icons.delete,
                  size: bs.sm,
                  onPressed: () {
                    _deleteSelectedFiles();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredFiles() {
    List<Map<String, dynamic>> filtered = allFiles;

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((file) => file["type"] == selectedCategory).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((file) {
        String name = file["name"].toString().toLowerCase();
        String extension = file["extension"].toString().toLowerCase();
        String query = searchQuery.toLowerCase();
        return name.contains(query) || extension.contains(query);
      }).toList();
    }

    // Sort files
    switch (sortBy) {
      case "Name":
        filtered.sort((a, b) => a["name"].toString().compareTo(b["name"].toString()));
        break;
      case "Size":
        filtered.sort((a, b) {
          double sizeA = a["size"] as double;
          double sizeB = b["size"] as double;
          if (a["unit"] == "GB") sizeA *= 1024;
          if (b["unit"] == "GB") sizeB *= 1024;
          return sizeB.compareTo(sizeA);
        });
        break;
      case "Date":
        filtered.sort((a, b) => b["dateModified"].toString().compareTo(a["dateModified"].toString()));
        break;
      case "Type":
        filtered.sort((a, b) => a["type"].toString().compareTo(b["type"].toString()));
        break;
    }

    return filtered;
  }

  bool _hasSelectedFiles() {
    return allFiles.any((file) => file["isSelected"]);
  }

  void _showFileOptions(Map<String, dynamic> file) {
    si("Options for ${file["name"]}: Open, Share, Rename, Delete, Properties");
  }

  void _showMoreOptions() {
    si("More options: Create folder, Sort options, View settings, Storage info");
  }

  void _shareSelectedFiles() {
    int selectedCount = allFiles.where((file) => file["isSelected"]).length;
    ss("$selectedCount files shared successfully");
  }

  void _moveSelectedFiles() {
    int selectedCount = allFiles.where((file) => file["isSelected"]).length;
    si("Moving $selectedCount files to new location");
  }

  void _deleteSelectedFiles() async {
    int selectedCount = allFiles.where((file) => file["isSelected"]).length;
    bool isConfirmed = await confirm("Delete $selectedCount selected files? This action cannot be undone.");
    
    if (isConfirmed) {
      allFiles.removeWhere((file) => file["isSelected"]);
      setState(() {});
      ss("$selectedCount files deleted successfully");
    }
  }
}
