import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaFileManagementView extends StatefulWidget {
  const PmaFileManagementView({super.key});

  @override
  State<PmaFileManagementView> createState() => _PmaFileManagementViewState();
}

class _PmaFileManagementViewState extends State<PmaFileManagementView> {
  String selectedFilter = "All";
  String searchQuery = "";
  String sortBy = "Recent";
  
  List<Map<String, dynamic>> fileCategories = [
    {"label": "All", "value": "All"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Images", "value": "Images"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Archives", "value": "Archives"},
    {"label": "Spreadsheets", "value": "Spreadsheets"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recent", "value": "Recent"},
    {"label": "Name", "value": "Name"},
    {"label": "Size", "value": "Size"},
    {"label": "Type", "value": "Type"},
  ];

  List<Map<String, dynamic>> files = [
    {
      "id": 1,
      "name": "Project Proposal.pdf",
      "type": "Documents",
      "size": "2.4 MB",
      "modified": "2024-01-15 14:30",
      "owner": "John Smith",
      "shared": true,
      "icon": Icons.picture_as_pdf,
      "color": Colors.red,
      "path": "/projects/marketing/proposals/",
      "permissions": "Read/Write",
      "version": "v1.2"
    },
    {
      "id": 2,
      "name": "Team Photo.jpg",
      "type": "Images",
      "size": "5.1 MB",
      "modified": "2024-01-14 09:15",
      "owner": "Sarah Johnson",
      "shared": false,
      "icon": Icons.image,
      "color": Colors.blue,
      "path": "/gallery/team/",
      "permissions": "Read Only",
      "version": "v1.0"
    },
    {
      "id": 3,
      "name": "Training Video.mp4",
      "type": "Videos",
      "size": "45.8 MB",
      "modified": "2024-01-13 16:45",
      "owner": "Mike Wilson",
      "shared": true,
      "icon": Icons.video_file,
      "color": Colors.purple,
      "path": "/videos/training/",
      "permissions": "Read/Write",
      "version": "v2.1"
    },
    {
      "id": 4,
      "name": "Budget_2024.xlsx",
      "type": "Spreadsheets",
      "size": "1.2 MB",
      "modified": "2024-01-12 11:20",
      "owner": "Lisa Brown",
      "shared": true,
      "icon": Icons.table_chart,
      "color": Colors.green,
      "path": "/finance/budgets/",
      "permissions": "Read/Write",
      "version": "v3.0"
    },
    {
      "id": 5,
      "name": "Archive_Q4.zip",
      "type": "Archives",
      "size": "12.7 MB",
      "modified": "2024-01-11 08:30",
      "owner": "Tom Davis",
      "shared": false,
      "icon": Icons.archive,
      "color": Colors.orange,
      "path": "/archives/quarterly/",
      "permissions": "Admin Only",
      "version": "v1.0"
    },
    {
      "id": 6,
      "name": "Meeting Notes.docx",
      "type": "Documents",
      "size": "890 KB",
      "modified": "2024-01-10 15:45",
      "owner": "Emma White",
      "shared": true,
      "icon": Icons.description,
      "color": Colors.blue,
      "path": "/documents/meetings/",
      "permissions": "Read/Write",
      "version": "v1.5"
    },
    {
      "id": 7,
      "name": "Logo_Design.png",
      "type": "Images",
      "size": "3.2 MB",
      "modified": "2024-01-09 12:10",
      "owner": "Alex Green",
      "shared": true,
      "icon": Icons.image,
      "color": Colors.blue,
      "path": "/design/logos/",
      "permissions": "Read Only",
      "version": "v2.3"
    },
    {
      "id": 8,
      "name": "Presentation.pptx",
      "type": "Documents",
      "size": "8.9 MB",
      "modified": "2024-01-08 13:25",
      "owner": "Chris Taylor",
      "shared": false,
      "icon": Icons.slideshow,
      "color": Colors.orange,
      "path": "/presentations/client/",
      "permissions": "Read/Write",
      "version": "v1.8"
    }
  ];

  List<Map<String, dynamic>> get filteredFiles {
    var result = files.where((file) {
      bool matchesFilter = selectedFilter == "All" || (file["type"] as String) == selectedFilter;
      bool matchesSearch = searchQuery.isEmpty || 
          (file["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (file["owner"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();

    switch (sortBy) {
      case "Name":
        result.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
        break;
      case "Size":
        result.sort((a, b) => (a["size"] as String).compareTo(b["size"] as String));
        break;
      case "Type":
        result.sort((a, b) => (a["type"] as String).compareTo(b["type"] as String));
        break;
      default:
        result.sort((a, b) => (b["modified"] as String).compareTo(a["modified"] as String));
    }

    return result;
  }

  Map<String, int> get storageStats {
    int totalFiles = files.length;
    int sharedFiles = files.where((f) => f["shared"] as bool).length;
    double totalSizeInMB = files.fold(0.0, (sum, file) {
      String sizeStr = file["size"] as String;
      double size = double.tryParse(sizeStr.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
      if (sizeStr.contains('KB')) size = size / 1024;
      if (sizeStr.contains('GB')) size = size * 1024;
      return sum + size;
    });
    
    return {
      "totalFiles": totalFiles,
      "sharedFiles": sharedFiles,
      "totalSize": totalSizeInMB.round(),
    };
  }

  @override
  Widget build(BuildContext context) {
    var stats = storageStats;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("File Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.create_new_folder),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Storage Overview Cards
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(Icons.folder, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Total Files",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${stats["totalFiles"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.share, color: successColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Shared",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${stats["sharedFiles"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.storage, color: warningColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Storage",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${stats["totalSize"]} MB",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
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
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Type",
                          items: fileCategories,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
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
            ),

            // Files List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Files (${filteredFiles.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.view_list, color: primaryColor, size: 20),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.grid_view, color: disabledBoldColor, size: 20),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: disabledOutlineBorderColor),
                  ...filteredFiles.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> file = entry.value;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: index < filteredFiles.length - 1
                              ? BorderSide(color: disabledOutlineBorderColor, width: 0.5)
                              : BorderSide.none,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (file["color"] as Color).withAlpha((0.1 * 255).round()),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              file["icon"] as IconData,
                              color: file["color"] as Color,
                              size: 20,
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
                                        "${file["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    if (file["shared"] as bool)
                                      Container(
                                        margin: EdgeInsets.only(left: spXs),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha((0.1 * 255).round()),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Shared",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: successColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      "${file["size"]} • ${file["owner"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${file["modified"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      "${file["path"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${file["version"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: infoColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, color: disabledBoldColor, size: 16),
                            onSelected: (value) {
                              // Handle menu actions
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: "download",
                                child: Row(
                                  children: [
                                    Icon(Icons.download, size: 16, color: primaryColor),
                                    SizedBox(width: spXs),
                                    Text("Download"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: "share",
                                child: Row(
                                  children: [
                                    Icon(Icons.share, size: 16, color: successColor),
                                    SizedBox(width: spXs),
                                    Text("Share"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: "rename",
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, size: 16, color: warningColor),
                                    SizedBox(width: spXs),
                                    Text("Rename"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: "delete",
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, size: 16, color: dangerColor),
                                    SizedBox(width: spXs),
                                    Text("Delete"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

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
                          label: "Upload File",
                          icon: Icons.upload_file,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "New Folder",
                          icon: Icons.create_new_folder,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Bulk Upload",
                          icon: Icons.cloud_upload,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Sync Drive",
                          icon: Icons.sync,
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
      ),
    );
  }
}
