import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStorage2View extends StatefulWidget {
  @override
  State<GrlStorage2View> createState() => _GrlStorage2ViewState();
}

class _GrlStorage2ViewState extends State<GrlStorage2View> {
  int currentTab = 0;
  String selectedCategory = "All";
  bool isSelectionMode = false;
  List<int> selectedItems = [];

  final List<Map<String, dynamic>> recentFiles = [
    {
      "name": "Quarterly_Report_Q4.pdf",
      "size": "2.4 MB",
      "modified": "2 hours ago",
      "type": "pdf",
      "thumbnail": "https://picsum.photos/100/100?random=1&keyword=document",
      "path": "/Documents/Reports/",
    },
    {
      "name": "Team_Meeting_Notes.docx",
      "size": "156 KB",
      "modified": "5 hours ago",
      "type": "document",
      "thumbnail": "https://picsum.photos/100/100?random=2&keyword=notes",
      "path": "/Documents/",
    },
    {
      "name": "Project_Mockup.figma",
      "size": "12.7 MB",
      "modified": "1 day ago",
      "type": "design",
      "thumbnail": "https://picsum.photos/100/100?random=3&keyword=design",
      "path": "/Design/Projects/",
    },
    {
      "name": "Vacation_Photos.zip",
      "size": "847 MB",
      "modified": "3 days ago",
      "type": "archive",
      "thumbnail": "https://picsum.photos/100/100?random=4&keyword=photos",
      "path": "/Downloads/",
    },
  ];

  final List<Map<String, dynamic>> cloudFiles = [
    {
      "name": "Backup_2024_01_15.zip",
      "size": "1.2 GB",
      "synced": "Synced",
      "type": "backup",
      "lastSync": "2 hours ago",
      "cloud": "Google Drive",
    },
    {
      "name": "Presentation_Draft.pptx",
      "size": "45.2 MB",
      "synced": "Syncing",
      "type": "presentation",
      "lastSync": "Syncing...",
      "cloud": "OneDrive",
    },
    {
      "name": "Family_Videos",
      "size": "3.8 GB",
      "synced": "Synced",
      "type": "folder",
      "lastSync": "1 day ago",
      "cloud": "iCloud",
    },
    {
      "name": "Work_Documents",
      "size": "567 MB",
      "synced": "Error",
      "type": "folder",
      "lastSync": "Failed",
      "cloud": "Dropbox",
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {"name": "All", "icon": Icons.folder, "count": 1249, "color": primaryColor},
    {"name": "Documents", "icon": Icons.description, "count": 345, "color": Colors.blue},
    {"name": "Images", "icon": Icons.image, "count": 678, "color": Colors.green},
    {"name": "Videos", "icon": Icons.video_library, "count": 89, "color": Colors.red},
    {"name": "Audio", "icon": Icons.audio_file, "count": 234, "color": Colors.purple},
    {"name": "Archives", "icon": Icons.archive, "count": 56, "color": Colors.orange},
  ];

  void _toggleSelection(int index) {
    if (selectedItems.contains(index)) {
      selectedItems.remove(index);
    } else {
      selectedItems.add(index);
    }
    
    if (selectedItems.isEmpty) {
      isSelectionMode = false;
    }
    setState(() {});
  }

  void _enterSelectionMode(int index) {
    isSelectionMode = true;
    selectedItems = [index];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + spSm,
              left: spMd,
              right: spMd,
              bottom: spSm,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryColor.withAlpha(20),
                  successColor.withAlpha(20),
                ],
              ),
            ),
            child: Row(
              children: [
                if (isSelectionMode) ...[
                  GestureDetector(
                    onTap: () {
                      isSelectionMode = false;
                      selectedItems.clear();
                      setState(() {});
                    },
                    child: Icon(
                      Icons.close,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "${selectedItems.length} selected",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.share,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.delete,
                          color: dangerColor,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  GestureDetector(
                    onTap: () => back(),
                    child: Icon(
                      Icons.arrow_back,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Storage",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "27.8 GB used of 64 GB",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.cloud_upload,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.search,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Tab Navigation
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowXs],
            ),
            child: Row(
              children: [
                _buildTab("Recent", 0),
                _buildTab("Categories", 1),
                _buildTab("Cloud", 2),
              ],
            ),
          ),

          // Content
          Expanded(
            child: IndexedStack(
              index: currentTab,
              children: [
                _buildRecentTab(),
                _buildCategoriesTab(),
                _buildCloudTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = currentTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          currentTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spMd),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? primaryColor : disabledBoldColor,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Actions
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(10)],
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.upload_file,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Upload File",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [successColor.withAlpha(20), successColor.withAlpha(10)],
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.create_new_folder,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "New Folder",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: spXl),

          // Recent Files Header
          Row(
            children: [
              Text(
                "Recent Files",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Recent Files List
          ...recentFiles.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> file = entry.value;
            bool isSelected = selectedItems.contains(index);

            return GestureDetector(
              onTap: () {
                if (isSelectionMode) {
                  _toggleSelection(index);
                }
              },
              onLongPress: () => _enterSelectionMode(index),
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowXs],
                  border: isSelected 
                      ? Border.all(color: primaryColor, width: 1)
                      : null,
                ),
                child: Row(
                  children: [
                    // Selection Checkbox
                    if (isSelectionMode)
                      Container(
                        margin: EdgeInsets.only(right: spMd),
                        child: Icon(
                          isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          size: 24,
                        ),
                      ),

                    // File Thumbnail
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${file["thumbnail"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),

                    // File Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${file["name"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${file["size"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                width: 3,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: disabledBoldColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${file["modified"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${file["path"]}",
                            style: TextStyle(
                              color: disabledColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // File Type Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getFileTypeColor(file["type"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        (file["type"] as String).toUpperCase(),
                        style: TextStyle(
                          color: _getFileTypeColor(file["type"] as String),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Categories Grid
          ResponsiveGridView(
            minItemWidth: 160,
            children: categories.map((category) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: (category["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        category["icon"] as IconData,
                        color: category["color"] as Color,
                        size: 32,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${category["count"]} files",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          SizedBox(height: spXl),

          // Storage Usage by Category
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Storage Usage by Category",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                
                _buildUsageBar("Images", 8.7, 27.8, Colors.green),
                _buildUsageBar("Videos", 12.5, 27.8, Colors.red),
                _buildUsageBar("Documents", 3.2, 27.8, Colors.blue),
                _buildUsageBar("Audio", 2.1, 27.8, Colors.purple),
                _buildUsageBar("Others", 1.3, 27.8, Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageBar(String category, double used, double total, Color color) {
    double percentage = used / total;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                category,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                "${used.toStringAsFixed(1)} GB",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloudTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cloud Services Status
          Text(
            "Connected Services",
            style: TextStyle(
              color: primaryColor,
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.cloud_done,
                        color: successColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "3",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Connected",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.sync,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "1",
                        style: TextStyle(
                          color: warningColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Syncing",
                        style: TextStyle(
                          color: warningColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: spXl),

          // Cloud Files
          Text(
            "Cloud Files",
            style: TextStyle(
              color: primaryColor,
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),

          ...cloudFiles.map((file) {
            Color statusColor = _getSyncStatusColor(file["synced"] as String);
            IconData statusIcon = _getSyncStatusIcon(file["synced"] as String);

            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowXs],
              ),
              child: Row(
                children: [
                  // Cloud Icon
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getCloudServiceColor(file["cloud"] as String).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.cloud,
                      color: _getCloudServiceColor(file["cloud"] as String),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),

                  // File Info
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
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    statusIcon,
                                    color: statusColor,
                                    size: 12,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${file["synced"]}",
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${file["size"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: disabledBoldColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${file["cloud"]}",
                              style: TextStyle(
                                color: _getCloudServiceColor(file["cloud"] as String),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${file["lastSync"]}",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action Button
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
          }).toList(),
        ],
      ),
    );
  }

  Color _getFileTypeColor(String type) {
    switch (type) {
      case "pdf":
        return Colors.red;
      case "document":
        return Colors.blue;
      case "design":
        return Colors.purple;
      case "archive":
        return Colors.orange;
      default:
        return primaryColor;
    }
  }

  Color _getSyncStatusColor(String status) {
    switch (status) {
      case "Synced":
        return successColor;
      case "Syncing":
        return warningColor;
      case "Error":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getSyncStatusIcon(String status) {
    switch (status) {
      case "Synced":
        return Icons.check_circle;
      case "Syncing":
        return Icons.sync;
      case "Error":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  Color _getCloudServiceColor(String service) {
    switch (service) {
      case "Google Drive":
        return Colors.blue;
      case "OneDrive":
        return Colors.indigo;
      case "iCloud":
        return Colors.grey;
      case "Dropbox":
        return Colors.blue;
      default:
        return primaryColor;
    }
  }
}
