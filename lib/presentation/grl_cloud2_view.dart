import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCloud2View extends StatefulWidget {
  @override
  State<GrlCloud2View> createState() => _GrlCloud2ViewState();
}

class _GrlCloud2ViewState extends State<GrlCloud2View> {
  String currentLocation = "/Documents/Projects";
  String selectedView = "List";
  bool isUploading = false;
  double uploadProgress = 0.0;
  String uploadFileName = "";

  List<Map<String, dynamic>> viewOptions = [
    {"label": "List", "value": "List"},
    {"label": "Grid", "value": "Grid"},
    {"label": "Details", "value": "Details"},
  ];

  List<Map<String, dynamic>> breadcrumbPath = [
    {"name": "Home", "path": "/"},
    {"name": "Documents", "path": "/Documents"},
    {"name": "Projects", "path": "/Documents/Projects"},
  ];

  List<Map<String, dynamic>> files = [
    {
      "name": "Mobile App Design",
      "type": "folder",
      "size": "",
      "modified": "2025-06-20",
      "shared": true,
      "favorite": false,
      "icon": Icons.folder,
      "color": primaryColor,
      "items": 24
    },
    {
      "name": "presentation.pptx",
      "type": "file",
      "size": "12.4 MB",
      "modified": "2025-06-19",
      "shared": false,
      "favorite": true,
      "icon": Icons.slideshow,
      "color": warningColor,
      "extension": "PPTX"
    },
    {
      "name": "Research Notes",
      "type": "folder",
      "size": "",
      "modified": "2025-06-18",
      "shared": false,
      "favorite": false,
      "icon": Icons.folder,
      "color": primaryColor,
      "items": 8
    },
    {
      "name": "budget_analysis.xlsx",
      "type": "file",
      "size": "2.1 MB",
      "modified": "2025-06-17",
      "shared": true,
      "favorite": false,
      "icon": Icons.table_chart,
      "color": successColor,
      "extension": "XLSX"
    },
    {
      "name": "team_photo.jpg",
      "type": "file",
      "size": "4.8 MB",
      "modified": "2025-06-16",
      "shared": false,
      "favorite": true,
      "icon": Icons.image,
      "color": infoColor,
      "extension": "JPG"
    },
    {
      "name": "project_backup.zip",
      "type": "file",
      "size": "89.2 MB",
      "modified": "2025-06-15",
      "shared": false,
      "favorite": false,
      "icon": Icons.archive,
      "color": dangerColor,
      "extension": "ZIP"
    },
    {
      "name": "Client Feedback",
      "type": "folder",
      "size": "",
      "modified": "2025-06-14",
      "shared": true,
      "favorite": false,
      "icon": Icons.folder,
      "color": primaryColor,
      "items": 15
    },
    {
      "name": "meeting_notes.pdf",
      "type": "file",
      "size": "1.2 MB",
      "modified": "2025-06-13",
      "shared": false,
      "favorite": false,
      "icon": Icons.picture_as_pdf,
      "color": dangerColor,
      "extension": "PDF"
    }
  ];

  List<Map<String, dynamic>> recentFiles = [
    {
      "name": "presentation.pptx",
      "path": "/Documents/Projects/",
      "modified": "2 hours ago",
      "icon": Icons.slideshow,
      "color": warningColor
    },
    {
      "name": "budget_analysis.xlsx",
      "path": "/Documents/Projects/",
      "modified": "1 day ago",
      "icon": Icons.table_chart,
      "color": successColor
    },
    {
      "name": "team_photo.jpg",
      "path": "/Pictures/Work/",
      "modified": "2 days ago",
      "icon": Icons.image,
      "color": infoColor
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Files"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _showSortOptions();
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
          _buildToolbar(),
          if (isUploading) _buildUploadProgress(),
          _buildBreadcrumb(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildFileList(),
                ),
                Container(
                  width: 1,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  flex: 1,
                  child: _buildSidebar(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showUploadOptions,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Row(
        children: [
          QButton(
            icon: Icons.arrow_back,
            size: bs.sm,
            onPressed: _canGoBack() ? _goBack : null,
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.arrow_forward,
            size: bs.sm,
            onPressed: () {
              si("Forward navigation not available");
            },
          ),
          SizedBox(width: spMd),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: _refreshFiles,
          ),
          Spacer(),
          QDropdownField(
            label: "View",
            items: viewOptions,
            value: selectedView,
            onChanged: (value, label) {
              selectedView = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUploadProgress() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        border: Border(
          bottom: BorderSide(color: infoColor.withAlpha(40)),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.cloud_upload,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Uploading $uploadFileName...",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: infoColor,
                ),
              ),
              Spacer(),
              Text(
                "${(uploadProgress * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              widthFactor: uploadProgress,
              child: Container(
                decoration: BoxDecoration(
                  color: infoColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumb() {
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
          Expanded(
            child: QHorizontalScroll(
              children: breadcrumbPath.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> item = entry.value;
                bool isLast = index == breadcrumbPath.length - 1;

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _navigateToPath(item["path"]);
                      },
                      child: Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isLast ? FontWeight.bold : FontWeight.w600,
                          color: isLast ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                    if (!isLast) ...[
                      SizedBox(width: spSm),
                      Icon(
                        Icons.chevron_right,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                    ],
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileList() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${files.length} items",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _selectAll,
                child: Text(
                  "Select All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: selectedView == "Grid" 
                ? _buildGridView()
                : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: files.length,
      itemBuilder: (context, index) {
        return _buildFileItem(files[index]);
      },
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: files.map((file) => _buildGridFileItem(file)).toList(),
    );
  }

  Widget _buildFileItem(Map<String, dynamic> file) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${file["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    if (file["favorite"]) ...[
                      Icon(
                        Icons.star,
                        color: warningColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                    ],
                    if (file["shared"]) ...[
                      Icon(
                        Icons.people,
                        color: infoColor,
                        size: 16,
                      ),
                    ],
                  ],
                ),
                Row(
                  children: [
                    if (file["type"] == "folder") ...[
                      Text(
                        "${file["items"]} items",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ] else ...[
                      if (file["extension"] != null) ...[
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
                      ],
                      Text(
                        "${file["size"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
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
              ],
            ),
          ),
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
    );
  }

  Widget _buildGridFileItem(Map<String, dynamic> file) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
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
              if (file["favorite"]) ...[
                Icon(
                  Icons.star,
                  color: warningColor,
                  size: 16,
                ),
              ],
              if (file["shared"]) ...[
                Icon(
                  Icons.people,
                  color: infoColor,
                  size: 16,
                ),
              ],
            ],
          ),
          Text(
            "${file["name"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (file["type"] == "folder") ...[
            Text(
              "${file["items"]} items",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ] else ...[
            Text(
              "${file["size"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
          Text(
            "${file["modified"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickAccess(),
          _buildRecentFiles(),
          _buildStorageInfo(),
        ],
      ),
    );
  }

  Widget _buildQuickAccess() {
    List<Map<String, dynamic>> quickItems = [
      {"name": "My Files", "icon": Icons.folder, "color": primaryColor},
      {"name": "Shared", "icon": Icons.people, "color": infoColor},
      {"name": "Favorites", "icon": Icons.star, "color": warningColor},
      {"name": "Trash", "icon": Icons.delete, "color": dangerColor},
    ];

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Access",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...quickItems.map((item) => Container(
          padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spSm),
          margin: EdgeInsets.only(bottom: spXs),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Icon(
                item["icon"] as IconData,
                color: item["color"] as Color,
                size: 18,
              ),
              SizedBox(width: spSm),
              Text(
                "${item["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildRecentFiles() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Files",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...recentFiles.map((file) => Container(
          padding: EdgeInsets.all(spSm),
          margin: EdgeInsets.only(bottom: spXs),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    file["icon"] as IconData,
                    color: file["color"] as Color,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${file["name"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Text(
                "${file["modified"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildStorageInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Storage",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Text(
                "8.5 GB",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                " of 15 GB",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              widthFactor: 0.567,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
          QButton(
            label: "Get More Space",
            size: bs.sm,
            onPressed: () {
              si("Opening storage upgrade options");
            },
          ),
        ],
      ),
    );
  }

  bool _canGoBack() {
    return breadcrumbPath.length > 1;
  }

  void _goBack() {
    if (_canGoBack()) {
      breadcrumbPath.removeLast();
      setState(() {});
      si("Navigated back to ${breadcrumbPath.last["name"]}");
    }
  }

  void _navigateToPath(String path) {
    si("Navigating to $path");
  }

  void _refreshFiles() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Files refreshed");
  }

  void _selectAll() {
    si("All files selected");
  }

  void _showFileOptions(Map<String, dynamic> file) {
    si("Options for ${file["name"]}: Download, Share, Rename, Move, Delete");
  }

  void _showSortOptions() {
    si("Sort options: Name, Size, Type, Modified Date");
  }

  void _showMoreOptions() {
    si("More options: New folder, Upload, Settings");
  }

  void _showUploadOptions() {
    si("Upload options: Files, Photos, Create folder");
    _simulateUpload();
  }

  void _simulateUpload() async {
    uploadFileName = "document.pdf";
    isUploading = true;
    uploadProgress = 0.0;
    setState(() {});

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: 50));
      uploadProgress = i / 100;
      setState(() {});
    }

    isUploading = false;
    setState(() {});
    ss("$uploadFileName uploaded successfully");
  }
}
