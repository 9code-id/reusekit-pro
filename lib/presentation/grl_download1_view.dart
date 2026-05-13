import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDownload1View extends StatefulWidget {
  @override
  State<GrlDownload1View> createState() => _GrlDownload1ViewState();
}

class _GrlDownload1ViewState extends State<GrlDownload1View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Images", "value": "Images"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Audio", "value": "Audio"},
    {"label": "Software", "value": "Software"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Downloading", "value": "Downloading"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Paused", "value": "Paused"},
    {"label": "Failed", "value": "Failed"},
  ];

  List<Map<String, dynamic>> downloads = [
    {
      "id": 1,
      "fileName": "Advanced_Machine_Learning_Textbook.pdf",
      "fileSize": 45600000,
      "downloadedSize": 45600000,
      "status": "Completed",
      "category": "Documents",
      "downloadSpeed": 0,
      "timeRemaining": 0,
      "startTime": "2024-12-21T14:30:00",
      "completedTime": "2024-12-21T14:35:20",
      "url": "https://example.com/ml-textbook.pdf",
      "savePath": "/Downloads/Documents/",
    },
    {
      "id": 2,
      "fileName": "Research_Presentation_Template.pptx",
      "fileSize": 12800000,
      "downloadedSize": 8960000,
      "status": "Downloading",
      "category": "Documents",
      "downloadSpeed": 2500000,
      "timeRemaining": 152,
      "startTime": "2024-12-21T15:10:00",
      "completedTime": "",
      "url": "https://example.com/presentation-template.pptx",
      "savePath": "/Downloads/Documents/",
    },
    {
      "id": 3,
      "fileName": "Scientific_Conference_Video.mp4",
      "fileSize": 1250000000,
      "downloadedSize": 625000000,
      "status": "Paused",
      "category": "Videos",
      "downloadSpeed": 0,
      "timeRemaining": 0,
      "startTime": "2024-12-21T13:45:00",
      "completedTime": "",
      "url": "https://example.com/conference-video.mp4",
      "savePath": "/Downloads/Videos/",
    },
    {
      "id": 4,
      "fileName": "Audio_Lecture_Series.zip",
      "fileSize": 456000000,
      "downloadedSize": 0,
      "status": "Failed",
      "category": "Audio",
      "downloadSpeed": 0,
      "timeRemaining": 0,
      "startTime": "2024-12-21T12:20:00",
      "completedTime": "",
      "url": "https://example.com/audio-lectures.zip",
      "savePath": "/Downloads/Audio/",
    },
    {
      "id": 5,
      "fileName": "Statistical_Analysis_Software.dmg",
      "fileSize": 2800000000,
      "downloadedSize": 2800000000,
      "status": "Completed",
      "category": "Software",
      "downloadSpeed": 0,
      "timeRemaining": 0,
      "startTime": "2024-12-20T09:15:00",
      "completedTime": "2024-12-20T10:45:30",
      "url": "https://example.com/stats-software.dmg",
      "savePath": "/Downloads/Software/",
    },
    {
      "id": 6,
      "fileName": "Research_Paper_Collection.pdf",
      "fileSize": 89600000,
      "downloadedSize": 71680000,
      "status": "Downloading",
      "category": "Documents",
      "downloadSpeed": 1800000,
      "timeRemaining": 320,
      "startTime": "2024-12-21T15:20:00",
      "completedTime": "",
      "url": "https://example.com/research-papers.pdf",
      "savePath": "/Downloads/Documents/",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Downloading":
        return infoColor;
      case "Completed":
        return successColor;
      case "Paused":
        return warningColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Documents":
        return primaryColor;
      case "Images":
        return successColor;
      case "Videos":
        return dangerColor;
      case "Audio":
        return warningColor;
      case "Software":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Documents":
        return Icons.description;
      case "Images":
        return Icons.image;
      case "Videos":
        return Icons.video_library;
      case "Audio":
        return Icons.audiotrack;
      case "Software":
        return Icons.apps;
      default:
        return Icons.file_copy;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes >= 1000000000) {
      return "${(bytes / 1000000000).toStringAsFixed(1)} GB";
    } else if (bytes >= 1000000) {
      return "${(bytes / 1000000).toStringAsFixed(1)} MB";
    } else if (bytes >= 1000) {
      return "${(bytes / 1000).toStringAsFixed(1)} KB";
    } else {
      return "$bytes B";
    }
  }

  String _formatSpeed(int bytesPerSecond) {
    if (bytesPerSecond >= 1000000) {
      return "${(bytesPerSecond / 1000000).toStringAsFixed(1)} MB/s";
    } else if (bytesPerSecond >= 1000) {
      return "${(bytesPerSecond / 1000).toStringAsFixed(1)} KB/s";
    } else {
      return "$bytesPerSecond B/s";
    }
  }

  String _formatTime(int seconds) {
    if (seconds >= 3600) {
      final hours = seconds ~/ 3600;
      final minutes = (seconds % 3600) ~/ 60;
      return "${hours}h ${minutes}m";
    } else if (seconds >= 60) {
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      return "${minutes}m ${remainingSeconds}s";
    } else {
      return "${seconds}s";
    }
  }

  double _getProgress(Map<String, dynamic> download) {
    final fileSize = download["fileSize"] as int;
    final downloadedSize = download["downloadedSize"] as int;
    if (fileSize == 0) return 0.0;
    return downloadedSize / fileSize;
  }

  List<Map<String, dynamic>> get filteredDownloads {
    List<Map<String, dynamic>> filtered = downloads;

    if (selectedCategory != "All") {
      filtered = filtered.where((download) => download["category"] == selectedCategory).toList();
    }

    if (selectedStatus != "All") {
      filtered = filtered.where((download) => download["status"] == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((download) =>
          (download["fileName"] as String).toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Manager"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.folder_open),
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
            // Search and Filters
            QTextField(
              label: "Search downloads",
              value: searchQuery,
              hint: "Search by filename",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

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
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Download Statistics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${downloads.length}",
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
                        height: 40,
                        width: 1,
                        color: disabledColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${downloads.where((d) => d["status"] == "Downloading").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: disabledColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${downloads.where((d) => d["status"] == "Completed").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Completed",
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
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Pause All",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Resume All",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Clear Completed",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Category Filter
            Text(
              "Browse by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: categories.skip(1).map((category) {
                final categoryName = category["value"] as String;
                final count = downloads.where((d) => d["category"] == categoryName).length;
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(categoryName).withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: _getCategoryColor(categoryName)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getCategoryIcon(categoryName),
                        size: 32,
                        color: _getCategoryColor(categoryName),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        categoryName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _getCategoryColor(categoryName),
                        ),
                      ),
                      Text(
                        "$count files",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Results
            Text(
              "${filteredDownloads.length} Downloads Found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),

            // Downloads List
            Column(
              spacing: spSm,
              children: filteredDownloads.map((download) {
                final progress = _getProgress(download);
                final isActive = download["status"] == "Downloading";
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: isActive
                        ? Border.all(color: infoColor.withAlpha(100))
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(download["category"] as String).withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getCategoryIcon(download["category"] as String),
                              color: _getCategoryColor(download["category"] as String),
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${download["fileName"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(download["status"] as String),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${download["status"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _formatFileSize(download["downloadedSize"] as int),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                    Text(
                                      " / ${_formatFileSize(download["fileSize"] as int)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${(progress * 100).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: disabledColor.withAlpha(50),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getStatusColor(download["status"] as String),
                          ),
                          minHeight: 8,
                        ),
                      ),

                      // Download Info
                      if (isActive)
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.speed,
                                size: 16,
                                color: infoColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Speed: ${_formatSpeed(download["downloadSpeed"] as int)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: infoColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "ETA: ${_formatTime(download["timeRemaining"] as int)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // File Details
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.folder,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "Save to: ${download["savePath"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Started: ${DateTime.parse(download["startTime"] as String).dMMMy} ${DateTime.parse(download["startTime"] as String).kkmm}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            if ((download["completedTime"] as String).isNotEmpty)
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Completed: ${DateTime.parse(download["completedTime"] as String).dMMMy} ${DateTime.parse(download["completedTime"] as String).kkmm}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: successColor,
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
                          if (download["status"] == "Downloading")
                            Expanded(
                              child: QButton(
                                label: "Pause",
                                size: bs.sm,
                                onPressed: () {
                                  download["status"] = "Paused";
                                  download["downloadSpeed"] = 0;
                                  setState(() {});
                                },
                              ),
                            )
                          else if (download["status"] == "Paused")
                            Expanded(
                              child: QButton(
                                label: "Resume",
                                size: bs.sm,
                                onPressed: () {
                                  download["status"] = "Downloading";
                                  download["downloadSpeed"] = 2000000;
                                  setState(() {});
                                },
                              ),
                            )
                          else if (download["status"] == "Failed")
                            Expanded(
                              child: QButton(
                                label: "Retry",
                                size: bs.sm,
                                onPressed: () {
                                  download["status"] = "Downloading";
                                  download["downloadSpeed"] = 1500000;
                                  setState(() {});
                                },
                              ),
                            )
                          else
                            Expanded(
                              child: QButton(
                                label: "Open File",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.folder_open,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.info_outline,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.delete_outline,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
