import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFile1View extends StatefulWidget {
  @override
  State<GrlFile1View> createState() => _GrlFile1ViewState();
}

class _GrlFile1ViewState extends State<GrlFile1View> {
  String searchQuery = "";
  String selectedFolder = "all";
  String sortBy = "name";
  bool isGridView = false;
  String filterType = "all";

  List<Map<String, dynamic>> folderItems = [
    {"label": "All Files", "value": "all"},
    {"label": "Documents", "value": "documents"},
    {"label": "Images", "value": "images"},
    {"label": "Videos", "value": "videos"},
    {"label": "Audio", "value": "audio"},
    {"label": "Downloads", "value": "downloads"},
  ];

  List<Map<String, dynamic>> sortByItems = [
    {"label": "Name", "value": "name"},
    {"label": "Date Modified", "value": "date"},
    {"label": "Size", "value": "size"},
    {"label": "Type", "value": "type"},
  ];

  List<Map<String, dynamic>> typeFilterItems = [
    {"label": "All Types", "value": "all"},
    {"label": "Documents", "value": "documents"},
    {"label": "Images", "value": "images"},
    {"label": "Videos", "value": "videos"},
    {"label": "Audio", "value": "audio"},
  ];

  List<Map<String, dynamic>> files = [
    {
      "name": "Annual Report 2024.pdf",
      "size": "2.4 MB",
      "type": "PDF Document",
      "modified": "2 hours ago",
      "icon": Icons.picture_as_pdf,
      "color": dangerColor,
      "folder": "Documents"
    },
    {
      "name": "Team Meeting Recording.mp4",
      "size": "145.7 MB",
      "type": "Video File",
      "modified": "5 hours ago",
      "icon": Icons.video_file,
      "color": primaryColor,
      "folder": "Videos"
    },
    {
      "name": "Budget Spreadsheet.xlsx",
      "size": "892 KB",
      "type": "Excel File",
      "modified": "1 day ago",
      "icon": Icons.table_chart,
      "color": successColor,
      "folder": "Documents"
    },
    {
      "name": "Project Images.zip",
      "size": "45.2 MB",
      "type": "Archive",
      "modified": "2 days ago",
      "icon": Icons.archive,
      "color": warningColor,
      "folder": "Downloads"
    },
    {
      "name": "Presentation Draft.pptx",
      "size": "12.8 MB",
      "type": "PowerPoint",
      "modified": "3 days ago",
      "icon": Icons.slideshow,
      "color": infoColor,
      "folder": "Documents"
    },
    {
      "name": "Profile Picture.jpg",
      "size": "1.2 MB",
      "type": "JPEG Image",
      "modified": "1 week ago",
      "icon": Icons.image,
      "color": successColor,
      "folder": "Images"
    },
    {
      "name": "Meeting Notes.docx",
      "size": "456 KB",
      "type": "Word Document",
      "modified": "2 weeks ago",
      "icon": Icons.description,
      "color": primaryColor,
      "folder": "Documents"
    },
    {
      "name": "Background Music.mp3",
      "size": "5.7 MB",
      "type": "Audio File",
      "modified": "3 weeks ago",
      "icon": Icons.audio_file,
      "color": dangerColor,
      "folder": "Audio"
    },
  ];

  List<Map<String, dynamic>> storageStats = [
    {
      "label": "Total Space",
      "value": "500 GB",
      "used": "340 GB",
      "percentage": 0.68,
      "color": primaryColor,
    },
    {
      "label": "Documents",
      "value": "125 GB",
      "used": "125 GB",
      "percentage": 0.25,
      "color": successColor,
    },
    {
      "label": "Images",
      "value": "89 GB",
      "used": "89 GB",
      "percentage": 0.178,
      "color": warningColor,
    },
    {
      "label": "Videos",
      "value": "78 GB",
      "used": "78 GB",
      "percentage": 0.156,
      "color": dangerColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Manager"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Storage Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.folder,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Storage Overview",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "340 GB / 500 GB",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: 0.68,
                    backgroundColor: Colors.white.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1,247",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Files",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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
                              "68%",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Space Used",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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
                              "160 GB",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Available",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search and Filters
            Text(
              "Search & Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search Files",
                          value: searchQuery,
                          hint: "Type to search files...",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),

                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Folder",
                          items: folderItems,
                          value: selectedFolder,
                          onChanged: (value, label) {
                            selectedFolder = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: typeFilterItems,
                          value: filterType,
                          onChanged: (value, label) {
                            filterType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  QDropdownField(
                    label: "Sort By",
                    items: sortByItems,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Storage Breakdown
            Text(
              "Storage Breakdown",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ResponsiveGridView(
              minItemWidth: 200,
              children: storageStats.map((stat) => Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: stat["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${stat["label"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: stat["color"] as Color,
                      ),
                    ),
                    LinearProgressIndicator(
                      value: stat["percentage"] as double,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(stat["color"] as Color),
                    ),
                  ],
                ),
              )).toList(),
            ),

            // Files List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Files",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${files.length} files",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            if (isGridView) ...[
              ResponsiveGridView(
                minItemWidth: 200,
                children: files.map((file) => _buildFileGridItem(file)).toList(),
              ),
            ] else ...[
              ...files.map((file) => _buildFileListItem(file)),
            ],

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Select All",
                    color: secondaryColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Upload Files",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileListItem(Map<String, dynamic> file) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${file["size"]} • ${file["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: (file["color"] as Color).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${file["folder"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: file["color"] as Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Modified ${file["modified"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: disabledBoldColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFileGridItem(Map<String, dynamic> file) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
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
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: disabledBoldColor,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${file["name"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spXs),
          Text(
            "${file["size"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spXs,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: (file["color"] as Color).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${file["folder"]}",
              style: TextStyle(
                fontSize: 10,
                color: file["color"] as Color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Modified ${file["modified"]}",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
