import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStorage5View extends StatefulWidget {
  @override
  State<GrlStorage5View> createState() => _GrlStorage5ViewState();
}

class _GrlStorage5ViewState extends State<GrlStorage5View> {
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Images", "value": "Images"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Archives", "value": "Archives"},
  ];

  List<Map<String, dynamic>> fileTypes = [
    {
      "name": "Images",
      "icon": Icons.image,
      "color": successColor,
      "count": 1247,
      "size": 8.2,
      "unit": "GB",
      "extensions": ["JPG", "PNG", "GIF", "SVG"],
      "growth": "+5.2%"
    },
    {
      "name": "Videos",
      "icon": Icons.video_file,
      "color": dangerColor,
      "count": 89,
      "size": 24.8,
      "unit": "GB",
      "extensions": ["MP4", "AVI", "MOV", "MKV"],
      "growth": "+12.1%"
    },
    {
      "name": "Documents",
      "icon": Icons.description,
      "color": primaryColor,
      "count": 2156,
      "size": 3.4,
      "unit": "GB",
      "extensions": ["PDF", "DOC", "XLS", "PPT"],
      "growth": "+2.8%"
    },
    {
      "name": "Archives",
      "icon": Icons.archive,
      "color": warningColor,
      "count": 42,
      "size": 5.6,
      "unit": "GB",
      "extensions": ["ZIP", "RAR", "7Z", "TAR"],
      "growth": "-1.2%"
    },
    {
      "name": "Audio",
      "icon": Icons.audio_file,
      "color": infoColor,
      "count": 892,
      "size": 2.1,
      "unit": "GB",
      "extensions": ["MP3", "WAV", "FLAC", "AAC"],
      "growth": "+0.5%"
    },
    {
      "name": "System Files",
      "icon": Icons.settings,
      "color": disabledBoldColor,
      "count": 15847,
      "size": 12.3,
      "unit": "GB",
      "extensions": ["SYS", "DLL", "EXE", "LOG"],
      "growth": "+8.9%"
    }
  ];

  List<Map<String, dynamic>> duplicateFiles = [
    {
      "name": "vacation_2024.jpg",
      "path": "/Pictures/Summer/",
      "copies": 3,
      "size": 4.2,
      "unit": "MB",
      "lastModified": "2 days ago",
      "icon": Icons.image
    },
    {
      "name": "project_report.pdf",
      "path": "/Documents/Work/",
      "copies": 5,
      "size": 12.8,
      "unit": "MB",
      "lastModified": "1 week ago",
      "icon": Icons.picture_as_pdf
    },
    {
      "name": "backup_config.zip",
      "path": "/Downloads/",
      "copies": 4,
      "size": 89.5,
      "unit": "MB",
      "lastModified": "3 days ago",
      "icon": Icons.archive
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Analytics"),
        actions: [
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStorageSummary(),
            _buildFilterSection(),
            _buildFileTypesGrid(),
            _buildDuplicateFiles(),
            _buildStorageRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildStorageSummary() {
    double totalSize = fileTypes.fold(0.0, (sum, type) => sum + (type["size"] as double));
    int totalFiles = fileTypes.fold(0, (sum, type) => sum + (type["count"] as int));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Text(
                "Storage Analysis",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${totalSize.toStringAsFixed(1)} GB",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Total Storage Used",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${(totalFiles / 1000).toStringAsFixed(1)}K",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Total Files",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      child: QCategoryPicker(
        items: filterOptions,
        value: selectedFilter,
        onChanged: (index, label, value, item) {
          selectedFilter = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildFileTypesGrid() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "File Types Distribution",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: fileTypes.map((fileType) => _buildFileTypeCard(fileType)).toList(),
        ),
      ],
    );
  }

  Widget _buildFileTypeCard(Map<String, dynamic> fileType) {
    bool isGrowthPositive = (fileType["growth"] as String).startsWith('+');
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(
            width: 4,
            color: fileType["color"] as Color,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (fileType["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  fileType["icon"] as IconData,
                  color: fileType["color"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${fileType["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${fileType["count"]} files",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: isGrowthPositive ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${fileType["growth"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isGrowthPositive ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${fileType["size"]} ${fileType["unit"]}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: fileType["color"] as Color,
                ),
              ),
              Spacer(),
              Text(
                "Storage Used",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              spacing: spXs,
              mainAxisSize: MainAxisSize.min,
              children: (fileType["extensions"] as List<String>).map((ext) => 
                Text(
                  ext,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ).toList(),
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Files",
              size: bs.sm,
              onPressed: () {
                si("Opening ${fileType["name"]} files");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDuplicateFiles() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Duplicate Files",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "Save 106.5 MB",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ),
          ],
        ),
        ...duplicateFiles.map((file) => _buildDuplicateFileItem(file)),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Clean All Duplicates",
            icon: Icons.cleaning_services,
            size: bs.md,
            onPressed: () {
              ss("Cleaning duplicate files");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDuplicateFileItem(Map<String, dynamic> file) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: warningColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            file["icon"] as IconData,
            color: warningColor,
            size: 24,
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
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${file["copies"]} copies",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      " • ${file["size"]} ${file["unit"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      " • ${file["lastModified"]}",
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
          QButton(
            label: "Clean",
            size: bs.sm,
            onPressed: () {
              ss("Cleaning ${file["name"]}");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStorageRecommendations() {
    List<Map<String, dynamic>> recommendations = [
      {
        "title": "Clean System Cache",
        "description": "Free up 1.2 GB by clearing temporary files",
        "icon": Icons.cleaning_services,
        "color": successColor,
        "action": "Clean Now"
      },
      {
        "title": "Archive Old Videos",
        "description": "Move videos older than 6 months to external storage",
        "icon": Icons.archive,
        "color": infoColor,
        "action": "Archive"
      },
      {
        "title": "Remove Empty Folders",
        "description": "Delete 47 empty folders taking up space",
        "icon": Icons.folder_delete,
        "color": warningColor,
        "action": "Remove"
      }
    ];

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Storage Recommendations",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...recommendations.map((rec) => Container(
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
                  color: (rec["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  rec["icon"] as IconData,
                  color: rec["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${rec["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${rec["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "${rec["action"]}",
                size: bs.sm,
                onPressed: () {
                  ss("${rec["action"]} completed");
                },
              ),
            ],
          ),
        )),
      ],
    );
  }
}
