import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmProjectFilesView extends StatefulWidget {
  const TpmProjectFilesView({super.key});

  @override
  State<TpmProjectFilesView> createState() => _TpmProjectFilesViewState();
}

class _TpmProjectFilesViewState extends State<TpmProjectFilesView> {
  String selectedCategory = "all";
  String sortBy = "name";
  bool isGridView = false;
  
  List<Map<String, dynamic>> projectFiles = [
    {
      "id": 1,
      "name": "Project_Requirements.pdf",
      "type": "pdf",
      "size": 2540000, // bytes
      "uploadedBy": "John Doe",
      "uploadedAt": DateTime.now().subtract(Duration(days: 5)),
      "category": "documents",
      "url": "https://example.com/files/project_requirements.pdf",
      "thumbnail": "https://picsum.photos/80/80?random=1",
      "downloads": 15,
      "lastModified": DateTime.now().subtract(Duration(days: 2)),
    },
    {
      "id": 2,
      "name": "UI_Mockups.fig",
      "type": "figma",
      "size": 15600000,
      "uploadedBy": "Jane Smith",
      "uploadedAt": DateTime.now().subtract(Duration(days: 3)),
      "category": "design",
      "url": "https://example.com/files/ui_mockups.fig",
      "thumbnail": "https://picsum.photos/80/80?random=2",
      "downloads": 8,
      "lastModified": DateTime.now().subtract(Duration(days: 1)),
    },
    {
      "id": 3,
      "name": "Database_Schema.sql",
      "type": "sql",
      "size": 45000,
      "uploadedBy": "Mike Johnson",
      "uploadedAt": DateTime.now().subtract(Duration(days: 7)),
      "category": "development",
      "url": "https://example.com/files/database_schema.sql",
      "thumbnail": "https://picsum.photos/80/80?random=3",
      "downloads": 12,
      "lastModified": DateTime.now().subtract(Duration(days: 4)),
    },
    {
      "id": 4,
      "name": "Meeting_Recording.mp4",
      "type": "video",
      "size": 125000000,
      "uploadedBy": "Sarah Wilson",
      "uploadedAt": DateTime.now().subtract(Duration(days: 1)),
      "category": "media",
      "url": "https://example.com/files/meeting_recording.mp4",
      "thumbnail": "https://picsum.photos/80/80?random=4",
      "downloads": 6,
      "lastModified": DateTime.now().subtract(Duration(hours: 5)),
    },
    {
      "id": 5,
      "name": "API_Documentation.docx",
      "type": "word",
      "size": 890000,
      "uploadedBy": "Tom Brown",
      "uploadedAt": DateTime.now().subtract(Duration(days: 4)),
      "category": "documents",
      "url": "https://example.com/files/api_documentation.docx",
      "thumbnail": "https://picsum.photos/80/80?random=5",
      "downloads": 20,
      "lastModified": DateTime.now().subtract(Duration(days: 1)),
    },
    {
      "id": 6,
      "name": "Project_Images.zip",
      "type": "archive",
      "size": 78000000,
      "uploadedBy": "Jane Smith",
      "uploadedAt": DateTime.now().subtract(Duration(days: 6)),
      "category": "media",
      "url": "https://example.com/files/project_images.zip",
      "thumbnail": "https://picsum.photos/80/80?random=6",
      "downloads": 4,
      "lastModified": DateTime.now().subtract(Duration(days: 3)),
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Files", "value": "all"},
    {"label": "Documents", "value": "documents"},
    {"label": "Design", "value": "design"},
    {"label": "Development", "value": "development"},
    {"label": "Media", "value": "media"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "name"},
    {"label": "Date", "value": "date"},
    {"label": "Size", "value": "size"},
    {"label": "Downloads", "value": "downloads"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Files"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () => _showUploadDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryOptions,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
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
                SizedBox(height: spMd),
                _buildFileStats(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: isGridView ? _buildGridView() : _buildListView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileStats() {
    List<Map<String, dynamic>> filteredFiles = _getFilteredFiles();
    int totalFiles = filteredFiles.length;
    double totalSize = filteredFiles.fold(0.0, (sum, file) => sum + (file["size"] as int));
    
    return Row(
      children: [
        _buildStatCard("Total Files", "$totalFiles", Icons.folder, primaryColor),
        SizedBox(width: spMd),
        _buildStatCard("Total Size", _formatFileSize(totalSize), Icons.storage, infoColor),
        SizedBox(width: spMd),
        _buildStatCard("Downloads", "${filteredFiles.fold(0, (sum, file) => sum + (file["downloads"] as int))}", Icons.download, successColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    title,
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
    );
  }

  Widget _buildListView() {
    List<Map<String, dynamic>> filteredFiles = _getFilteredFiles();
    
    return Column(
      spacing: spSm,
      children: filteredFiles.map((file) => _buildFileListItem(file)).toList(),
    );
  }

  Widget _buildFileListItem(Map<String, dynamic> file) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _getFileTypeColor(file["type"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getFileTypeIcon(file["type"]),
              color: _getFileTypeColor(file["type"]),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "By ${file["uploadedBy"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "•",
                      style: TextStyle(color: disabledColor),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${(file["uploadedAt"] as DateTime).dMMMy}",
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
                      _formatFileSize((file["size"] as int).toDouble()),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(Icons.download, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${file["downloads"]}",
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
            children: [
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () => _downloadFile(file),
              ),
              SizedBox(height: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showFileActions(file),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    List<Map<String, dynamic>> filteredFiles = _getFilteredFiles();
    
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredFiles.map((file) => _buildFileGridItem(file)).toList(),
    );
  }

  Widget _buildFileGridItem(Map<String, dynamic> file) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getFileTypeColor(file["type"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getFileTypeIcon(file["type"]),
                  color: _getFileTypeColor(file["type"]),
                  size: 20,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showFileActions(file),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${file["name"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          Text(
            "By ${file["uploadedBy"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${(file["uploadedAt"] as DateTime).dMMMy}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                _formatFileSize((file["size"] as int).toDouble()),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Icon(Icons.download, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${file["downloads"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Download",
              icon: Icons.download,
              size: bs.sm,
              onPressed: () => _downloadFile(file),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredFiles() {
    List<Map<String, dynamic>> filtered = projectFiles;
    
    if (selectedCategory != "all") {
      filtered = filtered.where((file) => file["category"] == selectedCategory).toList();
    }
    
    // Sort files
    filtered.sort((a, b) {
      switch (sortBy) {
        case "name":
          return (a["name"] as String).compareTo(b["name"] as String);
        case "date":
          return (b["uploadedAt"] as DateTime).compareTo(a["uploadedAt"] as DateTime);
        case "size":
          return (b["size"] as int).compareTo(a["size"] as int);
        case "downloads":
          return (b["downloads"] as int).compareTo(a["downloads"] as int);
        default:
          return 0;
      }
    });
    
    return filtered;
  }

  IconData _getFileTypeIcon(String type) {
    switch (type) {
      case "pdf":
        return Icons.picture_as_pdf;
      case "word":
        return Icons.description;
      case "figma":
        return Icons.design_services;
      case "sql":
        return Icons.code;
      case "video":
        return Icons.video_file;
      case "archive":
        return Icons.archive;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getFileTypeColor(String type) {
    switch (type) {
      case "pdf":
        return dangerColor;
      case "word":
        return primaryColor;
      case "figma":
        return successColor;
      case "sql":
        return warningColor;
      case "video":
        return infoColor;
      case "archive":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatFileSize(double bytes) {
    if (bytes < 1024) return "${bytes.toInt()} B";
    if (bytes < 1024 * 1024) return "${(bytes / 1024).toStringAsFixed(1)} KB";
    if (bytes < 1024 * 1024 * 1024) return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
    return "${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB";
  }

  void _downloadFile(Map<String, dynamic> file) {
    // Update download count
    setState(() {
      file["downloads"] = (file["downloads"] as int) + 1;
    });
    
    // Show download started message
    ss("Download started: ${file["name"]}");
  }

  void _showUploadDialog() {
    // Implementation for upload dialog
  }

  void _showFileActions(Map<String, dynamic> file) {
    // Implementation for file actions menu
  }
}
