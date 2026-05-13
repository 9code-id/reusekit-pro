import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFolder8View extends StatefulWidget {
  @override
  State<GrlFolder8View> createState() => _GrlFolder8ViewState();
}

class _GrlFolder8ViewState extends State<GrlFolder8View> {
  String searchQuery = "";
  String selectedPeriod = "This Week";
  bool showSystemFiles = false;

  List<Map<String, dynamic>> deletedItems = [
    {
      "id": 1,
      "name": "old_project_backup.zip",
      "type": "file",
      "originalSize": "125.4 MB",
      "deletedDate": "2024-01-15",
      "daysAgo": 2,
      "originalPath": "/Documents/Projects/",
      "deleteReason": "Manual deletion",
      "canRestore": true,
      "isSystemFile": false,
      "extension": "ZIP",
    },
    {
      "id": 2,
      "name": "Unused Templates",
      "type": "folder",
      "originalSize": "67.8 MB",
      "itemCount": 23,
      "deletedDate": "2024-01-14",
      "daysAgo": 3,
      "originalPath": "/Documents/",
      "deleteReason": "Manual deletion",
      "canRestore": true,
      "isSystemFile": false,
    },
    {
      "id": 3,
      "name": "screenshot_20240110.png",
      "type": "file",
      "originalSize": "3.2 MB",
      "deletedDate": "2024-01-13",
      "daysAgo": 4,
      "originalPath": "/Pictures/Screenshots/",
      "deleteReason": "Auto cleanup",
      "canRestore": true,
      "isSystemFile": false,
      "extension": "PNG",
    },
    {
      "id": 4,
      "name": "temp_cache_data",
      "type": "folder",
      "originalSize": "234.6 MB",
      "itemCount": 156,
      "deletedDate": "2024-01-12",
      "daysAgo": 5,
      "originalPath": "/System/Cache/",
      "deleteReason": "System cleanup",
      "canRestore": false,
      "isSystemFile": true,
    },
    {
      "id": 5,
      "name": "draft_document.docx",
      "type": "file",
      "originalSize": "2.8 MB",
      "deletedDate": "2024-01-10",
      "daysAgo": 7,
      "originalPath": "/Documents/Drafts/",
      "deleteReason": "Manual deletion",
      "canRestore": true,
      "isSystemFile": false,
      "extension": "DOCX",
    },
    {
      "id": 6,
      "name": "system_logs.log",
      "type": "file",
      "originalSize": "45.1 MB",
      "deletedDate": "2024-01-08",
      "daysAgo": 9,
      "originalPath": "/System/Logs/",
      "deleteReason": "Auto cleanup",
      "canRestore": false,
      "isSystemFile": true,
      "extension": "LOG",
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "All Time", "value": "All Time"},
  ];

  Color getFileTypeColor(String? extension) {
    if (extension == null) return disabledBoldColor;
    switch (extension.toUpperCase()) {
      case 'ZIP':
      case 'RAR':
        return warningColor;
      case 'PNG':
      case 'JPG':
      case 'GIF':
        return successColor;
      case 'DOCX':
      case 'DOC':
        return primaryColor;
      case 'LOG':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData getFileTypeIcon(String? extension) {
    if (extension == null) return Icons.insert_drive_file;
    switch (extension.toUpperCase()) {
      case 'ZIP':
      case 'RAR':
        return Icons.archive;
      case 'PNG':
      case 'JPG':
      case 'GIF':
        return Icons.image;
      case 'DOCX':
      case 'DOC':
        return Icons.description;
      case 'LOG':
        return Icons.assignment;
      default:
        return Icons.insert_drive_file;
    }
  }

  List<Map<String, dynamic>> get filteredItems {
    return deletedItems.where((item) {
      bool matchesSearch = item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSystem = showSystemFiles || !(item["isSystemFile"] as bool);
      bool matchesPeriod = true; // Simplified for demo
      return matchesSearch && matchesSystem && matchesPeriod;
    }).toList();
  }

  String get totalDeletedSize {
    double totalBytes = 0;
    for (var item in filteredItems) {
      String sizeStr = item["originalSize"] as String;
      double size = double.tryParse(sizeStr.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
      if (sizeStr.contains('MB')) size *= 1024 * 1024;
      if (sizeStr.contains('GB')) size *= 1024 * 1024 * 1024;
      totalBytes += size;
    }
    
    if (totalBytes > 1024 * 1024 * 1024) {
      return "${(totalBytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB";
    } else {
      return "${(totalBytes / (1024 * 1024)).toStringAsFixed(1)} MB";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trash"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search deleted items",
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

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: periodOptions,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Show System Files",
                        "value": true,
                        "checked": showSystemFiles,
                      }
                    ],
                    value: [if (showSystemFiles) {"label": "Show System Files", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showSystemFiles = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Trash Statistics
            Container(
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
                      Icon(Icons.delete, color: dangerColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Trash Statistics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${filteredItems.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Items in Trash",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              totalDeletedSize,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Space Freed",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Empty Trash",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Auto-Delete Warning
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.schedule, color: warningColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Auto-Delete Notice",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Items in trash are automatically deleted after 30 days",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Deleted Items List
            Text(
              "Deleted Items (${filteredItems.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: item["isSystemFile"] == true 
                      ? Border.all(color: disabledColor.withAlpha(50), width: 1)
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        // File Icon
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: item["type"] == "folder" 
                                ? dangerColor.withAlpha(30) 
                                : getFileTypeColor(item["extension"] as String?).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            item["type"] == "folder" 
                                ? Icons.folder_delete 
                                : getFileTypeIcon(item["extension"] as String?),
                            color: item["type"] == "folder" 
                                ? dangerColor 
                                : getFileTypeColor(item["extension"] as String?),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: item["isSystemFile"] == true ? disabledBoldColor : primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (item["isSystemFile"] == true)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: disabledColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "SYSTEM",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Row(
                                children: [
                                  if (item["type"] == "folder")
                                    Text(
                                      "${item["itemCount"]} items • ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    )
                                  else if (item["extension"] != null)
                                    Text(
                                      "${item["extension"]} • ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  Text(
                                    "${item["originalSize"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${item["daysAgo"]} days ago",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Original Path and Delete Reason
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.folder_outlined, color: disabledBoldColor, size: 14),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "Original Path: ${item["originalPath"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.info_outline, color: disabledBoldColor, size: 14),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "Reason: ${item["deleteReason"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        if (item["canRestore"] == true) ...[
                          Expanded(
                            child: QButton(
                              label: "Restore",
                              icon: Icons.restore,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                        ],
                        Expanded(
                          child: QButton(
                            label: "Delete Forever",
                            icon: Icons.delete_forever,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.info,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),

                    // Auto-Delete Warning for individual items
                    if (item["daysAgo"] as int >= 25)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning, color: dangerColor, size: 14),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Will be permanently deleted in ${30 - (item["daysAgo"] as int)} days",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),

            // Empty State
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
                    Icon(Icons.delete_outline, color: disabledColor, size: 64),
                    SizedBox(height: spMd),
                    Text(
                      "Trash is Empty",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Deleted files will appear here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
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
}
