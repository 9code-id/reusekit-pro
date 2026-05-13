import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFolder2View extends StatefulWidget {
  @override
  State<GrlFolder2View> createState() => _GrlFolder2ViewState();
}

class _GrlFolder2ViewState extends State<GrlFolder2View> {
  String searchQuery = "";
  String selectedSort = "Name";
  String selectedView = "Grid";
  bool showHidden = false;
  String currentPath = "/Documents/Projects";

  List<Map<String, dynamic>> sortItems = [
    {"label": "Name", "value": "Name"},
    {"label": "Date Modified", "value": "Date Modified"},
    {"label": "Size", "value": "Size"},
    {"label": "Type", "value": "Type"},
  ];

  List<Map<String, dynamic>> viewItems = [
    {"label": "Grid", "value": "Grid"},
    {"label": "List", "value": "List"},
    {"label": "Details", "value": "Details"},
  ];

  List<Map<String, dynamic>> breadcrumbs = [
    {"name": "Home", "path": "/"},
    {"name": "Documents", "path": "/Documents"},
    {"name": "Projects", "path": "/Documents/Projects"},
  ];

  List<Map<String, dynamic>> folders = [
    {
      "name": "Marketing Campaign 2024",
      "type": "folder",
      "files": 45,
      "size": "2.4 GB",
      "modified": "2024-06-22",
      "color": Colors.blue,
      "shared": true,
      "synced": true,
    },
    {
      "name": "Development Documentation",
      "type": "folder",
      "files": 128,
      "size": "890 MB",
      "modified": "2024-06-21",
      "color": Colors.green,
      "shared": false,
      "synced": true,
    },
    {
      "name": "Client Assets",
      "type": "folder",
      "files": 67,
      "size": "1.8 GB",
      "modified": "2024-06-20",
      "color": Colors.orange,
      "shared": true,
      "synced": false,
    },
    {
      "name": "Archive",
      "type": "folder",
      "files": 234,
      "size": "5.2 GB",
      "modified": "2024-06-15",
      "color": Colors.grey,
      "shared": false,
      "synced": true,
    },
  ];

  List<Map<String, dynamic>> files = [
    {
      "name": "Project_Proposal.pdf",
      "type": "file",
      "extension": "pdf",
      "size": "2.4 MB",
      "modified": "2024-06-22",
      "icon": Icons.picture_as_pdf,
      "color": Colors.red,
    },
    {
      "name": "Budget_Analysis.xlsx",
      "type": "file",
      "extension": "xlsx",
      "size": "1.2 MB",
      "modified": "2024-06-21",
      "icon": Icons.table_chart,
      "color": Colors.green,
    },
    {
      "name": "Team_Photo.jpg",
      "type": "file",
      "extension": "jpg",
      "size": "3.8 MB",
      "modified": "2024-06-20",
      "icon": Icons.image,
      "color": Colors.blue,
    },
    {
      "name": "Meeting_Recording.mp4",
      "type": "file",
      "extension": "mp4",
      "size": "45.3 MB",
      "modified": "2024-06-19",
      "icon": Icons.video_file,
      "color": Colors.purple,
    },
  ];

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Folder Browser"),
        actions: [
          IconButton(
            icon: Icon(selectedView == "Grid" ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              selectedView = selectedView == "Grid" ? "List" : "Grid";
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Breadcrumb Navigation
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                // Breadcrumbs
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: breadcrumbs.asMap().entries.map((entry) {
                      final index = entry.key;
                      final breadcrumb = entry.value;
                      final isLast = index == breadcrumbs.length - 1;
                      
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "${breadcrumb["name"]}",
                              style: TextStyle(
                                color: isLast ? primaryColor : disabledBoldColor,
                                fontWeight: isLast ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (!isLast) ...[
                            SizedBox(width: spXs),
                            Icon(
                              Icons.chevron_right,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                          ],
                        ],
                      );
                    }).toList(),
                  ),
                ),

                // Search and Filter Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: spSm),
                              child: Icon(
                                Icons.search,
                                color: disabledBoldColor,
                                size: 20,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search in this folder...",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: spSm),
                                ),
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: primaryColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),

                // Sort and View Options
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Sort by",
                        items: sortItems,
                        value: selectedSort,
                        onChanged: (value, label) {
                          selectedSort = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QSwitch(
                      items: [
                        {
                          "label": "Show hidden",
                          "value": true,
                          "checked": showHidden,
                        }
                      ],
                      value: [if (showHidden) {"label": "Show hidden", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        setState(() {
                          showHidden = values.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Folders Section
                  if (folders.isNotEmpty) ...[
                    Text(
                      "Folders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    selectedView == "Grid" ? _buildFoldersGrid() : _buildFoldersList(),
                  ],

                  // Files Section
                  if (files.isNotEmpty) ...[
                    Text(
                      "Files",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    selectedView == "Grid" ? _buildFilesGrid() : _buildFilesList(),
                  ],

                  // Empty State
                  if (folders.isEmpty && files.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.folder_open,
                            size: 64,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "This folder is empty",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Upload files or create folders to get started",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: spMd),
                          QButton(
                            label: "Upload Files",
                            icon: Icons.upload,
                            size: bs.md,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Bottom Action Bar (if items selected)
          if (selectedItems.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "${selectedItems.length} items selected",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Move",
                          icon: Icons.drive_file_move,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Copy",
                          icon: Icons.copy,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Share",
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Delete",
                          icon: Icons.delete,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFoldersGrid() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: folders.map((folder) {
        final isSelected = selectedItems.contains(folder["name"]);
        
        return Container(
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
            border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
          ),
          child: GestureDetector(
            onTap: () {
              if (isSelected) {
                selectedItems.remove(folder["name"]);
              } else {
                selectedItems.add(folder["name"] as String);
              }
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.folder,
                        color: folder["color"] as Color,
                        size: 32,
                      ),
                      Spacer(),
                      if (folder["shared"] as bool)
                        Icon(Icons.people, color: disabledBoldColor, size: 16),
                      if (folder["synced"] as bool) ...[
                        SizedBox(width: spXs),
                        Icon(Icons.cloud_done, color: Colors.green, size: 16),
                      ],
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${folder["name"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${folder["files"]} files • ${folder["size"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Modified ${DateTime.parse(folder["modified"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFoldersList() {
    return Column(
      children: folders.map((folder) {
        final isSelected = selectedItems.contains(folder["name"]);
        
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
            border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
          ),
          child: GestureDetector(
            onTap: () {
              if (isSelected) {
                selectedItems.remove(folder["name"]);
              } else {
                selectedItems.add(folder["name"] as String);
              }
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Row(
                children: [
                  Icon(
                    Icons.folder,
                    color: folder["color"] as Color,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${folder["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${folder["files"]} files • ${folder["size"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          if (folder["shared"] as bool)
                            Icon(Icons.people, color: disabledBoldColor, size: 16),
                          if (folder["synced"] as bool) ...[
                            SizedBox(width: spXs),
                            Icon(Icons.cloud_done, color: Colors.green, size: 16),
                          ],
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${DateTime.parse(folder["modified"]).dMMMy}",
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
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFilesGrid() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: files.map((file) {
        final isSelected = selectedItems.contains(file["name"]);
        
        return Container(
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
            border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
          ),
          child: GestureDetector(
            onTap: () {
              if (isSelected) {
                selectedItems.remove(file["name"]);
              } else {
                selectedItems.add(file["name"] as String);
              }
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: (file["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      file["icon"] as IconData,
                      color: file["color"] as Color,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${file["name"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${file["extension"]?.toUpperCase()} • ${file["size"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFilesList() {
    return Column(
      children: files.map((file) {
        final isSelected = selectedItems.contains(file["name"]);
        
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
            border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
          ),
          child: GestureDetector(
            onTap: () {
              if (isSelected) {
                selectedItems.remove(file["name"]);
              } else {
                selectedItems.add(file["name"] as String);
              }
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
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
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${file["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${file["extension"]?.toUpperCase()} • ${file["size"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${DateTime.parse(file["modified"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
