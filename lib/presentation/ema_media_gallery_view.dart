import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaMediaGalleryView extends StatefulWidget {
  const EmaMediaGalleryView({super.key});

  @override
  State<EmaMediaGalleryView> createState() => _EmaMediaGalleryViewState();
}

class _EmaMediaGalleryViewState extends State<EmaMediaGalleryView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "newest";
  bool isGridView = true;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Images", "value": "Images"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Presentations", "value": "Presentations"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Name A-Z", "value": "name_asc"},
    {"label": "Name Z-A", "value": "name_desc"},
    {"label": "Size Large-Small", "value": "size_desc"},
    {"label": "Size Small-Large", "value": "size_asc"},
  ];

  List<Map<String, dynamic>> mediaItems = [
    {
      "id": "media_001",
      "name": "AI_Healthcare_Infographic.jpg",
      "type": "image",
      "category": "Images",
      "size": "2.4 MB",
      "uploadDate": "2024-12-18",
      "dimensions": "1920x1080",
      "description": "Comprehensive infographic showing AI applications in healthcare",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=healthcare",
      "url": "https://picsum.photos/1920/1080?random=1&keyword=healthcare",
      "tags": ["healthcare", "AI", "infographic", "medical"],
      "uploadedBy": "Dr. Sarah Johnson",
      "views": 1247,
      "downloads": 89,
    },
    {
      "id": "media_002",
      "name": "Medical_AI_Presentation.mp4",
      "type": "video",
      "category": "Videos",
      "size": "145 MB",
      "uploadDate": "2024-12-16",
      "duration": "15:30",
      "description": "Detailed presentation on machine learning in medical diagnostics",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=medical",
      "url": "https://picsum.photos/1920/1080?random=2&keyword=medical",
      "tags": ["presentation", "machine learning", "diagnostics", "video"],
      "uploadedBy": "Prof. Michael Chen",
      "views": 892,
      "downloads": 56,
    },
    {
      "id": "media_003",
      "name": "Healthcare_Research_Paper.pdf",
      "type": "document",
      "category": "Documents",
      "size": "3.2 MB",
      "uploadDate": "2024-12-15",
      "pages": 24,
      "description": "Research paper on AI implementation in modern healthcare systems",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=research",
      "url": "https://picsum.photos/800/600?random=3&keyword=research",
      "tags": ["research", "healthcare", "AI", "academic"],
      "uploadedBy": "Dr. Emily Rodriguez",
      "views": 634,
      "downloads": 123,
    },
    {
      "id": "media_004",
      "name": "Telemedicine_Workflow.pptx",
      "type": "presentation",
      "category": "Presentations",
      "size": "8.7 MB",
      "uploadDate": "2024-12-14",
      "slides": 32,
      "description": "Complete workflow guide for implementing telemedicine solutions",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=telehealth",
      "url": "https://picsum.photos/800/600?random=4&keyword=telehealth",
      "tags": ["telemedicine", "workflow", "implementation", "slides"],
      "uploadedBy": "Alex Thompson",
      "views": 445,
      "downloads": 67,
    },
    {
      "id": "media_005",
      "name": "Digital_Health_Security.jpg",
      "type": "image",
      "category": "Images",
      "size": "1.8 MB",
      "uploadDate": "2024-12-13",
      "dimensions": "1600x900",
      "description": "Cybersecurity framework for digital health applications",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=security",
      "url": "https://picsum.photos/1600/900?random=5&keyword=security",
      "tags": ["security", "digital health", "cybersecurity", "framework"],
      "uploadedBy": "Dr. Maria Garcia",
      "views": 723,
      "downloads": 45,
    },
    {
      "id": "media_006",
      "name": "Patient_Data_Analytics.mp4",
      "type": "video",
      "category": "Videos",
      "size": "89 MB",
      "uploadDate": "2024-12-12",
      "duration": "12:45",
      "description": "Tutorial on analyzing patient data using modern analytics tools",
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=analytics",
      "url": "https://picsum.photos/1920/1080?random=6&keyword=analytics",
      "tags": ["analytics", "patient data", "tutorial", "healthcare"],
      "uploadedBy": "Dr. Sarah Johnson",
      "views": 567,
      "downloads": 34,
    },
    {
      "id": "media_007",
      "name": "Medical_Device_Integration.pdf",
      "type": "document",
      "category": "Documents",
      "size": "4.1 MB",
      "uploadDate": "2024-12-11",
      "pages": 18,
      "description": "Guidelines for integrating IoT medical devices with healthcare systems",
      "thumbnail": "https://picsum.photos/300/200?random=7&keyword=devices",
      "url": "https://picsum.photos/800/600?random=7&keyword=devices",
      "tags": ["IoT", "medical devices", "integration", "guidelines"],
      "uploadedBy": "Alex Thompson",
      "views": 389,
      "downloads": 78,
    },
    {
      "id": "media_008",
      "name": "Healthcare_Innovation_Trends.pptx",
      "type": "presentation",
      "category": "Presentations",
      "size": "12.3 MB",
      "uploadDate": "2024-12-10",
      "slides": 45,
      "description": "Latest trends and innovations shaping the future of healthcare",
      "thumbnail": "https://picsum.photos/300/200?random=8&keyword=innovation",
      "url": "https://picsum.photos/800/600?random=8&keyword=innovation",
      "tags": ["innovation", "trends", "healthcare", "future"],
      "uploadedBy": "Prof. Michael Chen",
      "views": 912,
      "downloads": 156,
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    var filtered = mediaItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty || 
          item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();

    // Sort items
    switch (sortBy) {
      case "oldest":
        filtered.sort((a, b) => a["uploadDate"].compareTo(b["uploadDate"]));
        break;
      case "name_asc":
        filtered.sort((a, b) => a["name"].compareTo(b["name"]));
        break;
      case "name_desc":
        filtered.sort((a, b) => b["name"].compareTo(a["name"]));
        break;
      case "size_desc":
        filtered.sort((a, b) => _getSizeInBytes(b["size"]).compareTo(_getSizeInBytes(a["size"])));
        break;
      case "size_asc":
        filtered.sort((a, b) => _getSizeInBytes(a["size"]).compareTo(_getSizeInBytes(b["size"])));
        break;
      default: // newest
        filtered.sort((a, b) => b["uploadDate"].compareTo(a["uploadDate"]));
    }

    return filtered;
  }

  int _getSizeInBytes(String size) {
    double value = double.parse(size.split(' ')[0]);
    String unit = size.split(' ')[1];
    switch (unit) {
      case "GB":
        return (value * 1024 * 1024 * 1024).round();
      case "MB":
        return (value * 1024 * 1024).round();
      case "KB":
        return (value * 1024).round();
      default:
        return value.round();
    }
  }

  void _downloadMedia(Map<String, dynamic> item) {
    ss("Downloading ${item["name"]}");
  }

  void _shareMedia(Map<String, dynamic> item) {
    ss("Sharing ${item["name"]}");
  }

  void _deleteMedia(String mediaId) {
    mediaItems.removeWhere((item) => item["id"] == mediaId);
    ss("Media deleted successfully");
    setState(() {});
  }

  void _previewMedia(Map<String, dynamic> item) {
    ss("Previewing ${item["name"]}");
  }

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Media Gallery",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Gallery", icon: Icon(Icons.photo_library)),
        Tab(text: "Upload", icon: Icon(Icons.cloud_upload)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildGalleryTab(),
        _buildUploadTab(),
        _buildAnalyticsTab(),
        _buildSettingsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildGalleryTab() {
    return Column(
      children: [
        // Search and Filter Bar
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
                    child: QTextField(
                      label: "Search media",
                      value: searchQuery,
                      hint: "Search by name, description, or tags...",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  GestureDetector(
                    onTap: () {
                      isGridView = !isGridView;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        isGridView ? Icons.list : Icons.grid_view,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
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
            ],
          ),
        ),

        // Media Gallery
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: isGridView ? _buildGridView() : _buildListView(),
          ),
        ),
      ],
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredItems.map((item) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            GestureDetector(
              onTap: () => _previewMedia(item),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                  image: DecorationImage(
                    image: NetworkImage("${item["thumbnail"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getTypeColor(item["type"]),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${item["type"].toString().toUpperCase()}",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (item["type"] == "video") ...[
                      Positioned(
                        bottom: spSm,
                        right: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(200),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["duration"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getTypeIcon(item["type"]),
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Media Info
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${item["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "${item["size"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${item["uploadDate"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.visibility, color: disabledBoldColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${item["views"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.download, color: disabledBoldColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${item["downloads"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () => _downloadMedia(item),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.share,
                        size: bs.sm,
                        onPressed: () => _shareMedia(item),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.delete,
                        color: dangerColor,
                        size: bs.sm,
                        onPressed: () => _deleteMedia(item["id"]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildListView() {
    return Column(
      children: filteredItems.map((item) => Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            // Thumbnail
            GestureDetector(
              onTap: () => _previewMedia(item),
              child: Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${item["thumbnail"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        _getTypeIcon(item["type"]),
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: spMd),
            
            // Media Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${item["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getTypeColor(item["type"]),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${item["type"].toString().toUpperCase()}",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${item["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "${item["size"]} • ${item["uploadDate"]} • by ${item["uploadedBy"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.visibility, color: disabledBoldColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${item["views"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(Icons.download, color: disabledBoldColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${item["downloads"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Actions
            Column(
              children: [
                QButton(
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () => _downloadMedia(item),
                ),
                SizedBox(height: spSm),
                QButton(
                  icon: Icons.share,
                  size: bs.sm,
                  onPressed: () => _shareMedia(item),
                ),
                SizedBox(height: spSm),
                QButton(
                  icon: Icons.delete,
                  color: dangerColor,
                  size: bs.sm,
                  onPressed: () => _deleteMedia(item["id"]),
                ),
              ],
            ),
          ],
        ),
      )).toList(),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "image":
        return successColor;
      case "video":
        return primaryColor;
      case "document":
        return warningColor;
      case "presentation":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "image":
        return Icons.image;
      case "video":
        return Icons.play_arrow;
      case "document":
        return Icons.description;
      case "presentation":
        return Icons.slideshow;
      default:
        return Icons.file_present;
    }
  }

  Widget _buildUploadTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upload Area
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(radiusLg),
              color: primaryColor.withAlpha(25),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload,
                  color: primaryColor,
                  size: 64,
                ),
                SizedBox(height: spMd),
                Text(
                  "Upload Media Files",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Drag and drop files here or click to browse",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spLg),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Browse Files",
                    size: bs.md,
                    onPressed: () {
                      ss("Opening file browser");
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Upload Options
          Text(
            "Upload Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                QDropdownField(
                  label: "Upload Category",
                  items: categories.where((cat) => cat["value"] != "All").toList(),
                  value: "Images",
                  onChanged: (value, label) {
                    setState(() {});
                  },
                ),

                QSwitch(
                  label: "Upload Options",
                  items: [
                    {
                      "label": "Auto-compress large files",
                      "value": "compress",
                      "checked": true,
                    },
                    {
                      "label": "Generate thumbnails",
                      "value": "thumbnails",
                      "checked": true,
                    },
                    {
                      "label": "Create backup copies",
                      "value": "backup",
                      "checked": false,
                    },
                  ],
                  value: [
                    {"label": "Auto-compress large files", "value": "compress", "checked": true},
                    {"label": "Generate thumbnails", "value": "thumbnails", "checked": true},
                  ],
                  onChanged: (values, ids) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Supported Formats
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor, size: 20),
                    SizedBox(width: spMd),
                    Text(
                      "Supported Formats",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "Images: JPG, PNG, GIF, WebP (max 50 MB)\n"
                  "Videos: MP4, AVI, MOV, WebM (max 500 MB)\n"
                  "Documents: PDF, DOC, DOCX, TXT (max 100 MB)\n"
                  "Presentations: PPT, PPTX, KEY (max 200 MB)",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Recent Uploads
          Text(
            "Recent Uploads",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...mediaItems.take(3).map((item) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    image: DecorationImage(
                      image: NetworkImage("${item["thumbnail"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${item["size"]} • ${item["uploadDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "UPLOADED",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Media Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          // Analytics Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.photo_library, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "${mediaItems.length}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Files",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.visibility, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "${mediaItems.fold(0, (sum, item) => sum + (item["views"] as int))}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Views",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.download, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "${mediaItems.fold(0, (sum, item) => sum + (item["downloads"] as int))}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Downloads",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.storage, color: infoColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "267 MB",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Storage Used",
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

          SizedBox(height: spLg),

          // Most Popular Media
          Text(
            "Most Popular Media",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...mediaItems.where((item) => (item["views"] as int) > 500)
              .map((item) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${item["thumbnail"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${item["uploadDate"]} • ${item["size"]}",
                        style: TextStyle(
                          fontSize: 11,
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
                        Icon(Icons.visibility, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${item["views"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.download, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${item["downloads"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gallery Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          // Storage Settings
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Storage Management",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Clear Cache",
                        color: warningColor,
                        size: bs.sm,
                        onPressed: () {
                          ss("Cache cleared");
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QButton(
                        label: "Optimize Storage",
                        size: bs.sm,
                        onPressed: () {
                          ss("Storage optimized");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Auto-backup Settings
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Auto-Backup Settings",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Enable automatic backup to cloud storage",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: true,
                      onChanged: (value) {
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Export Options
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Export Options",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Export All Media",
                    size: bs.md,
                    onPressed: () {
                      ss("Exporting all media files");
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
}
