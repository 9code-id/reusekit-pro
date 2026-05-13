import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDownload3View extends StatefulWidget {
  const GrlDownload3View({Key? key}) : super(key: key);

  @override
  State<GrlDownload3View> createState() => _GrlDownload3ViewState();
}

class _GrlDownload3ViewState extends State<GrlDownload3View> {
  String selectedCategory = "All";
  String searchQuery = "";
  String selectedFormat = "All";
  bool showCompleted = true;
  bool showInProgress = true;
  bool showPaused = true;
  bool showFailed = true;

  List<Map<String, dynamic>> downloads = [
    {
      "id": "1",
      "name": "Complete Flutter Course.zip",
      "type": "Archive",
      "size": 2.5,
      "downloaded": 2.5,
      "status": "Completed",
      "speed": "0 MB/s",
      "timeRemaining": "Completed",
      "url": "https://example.com/flutter-course.zip",
      "downloadPath": "/Downloads/Courses/",
      "dateAdded": "2024-01-15",
      "dateCompleted": "2024-01-15",
      "category": "Education",
      "format": "ZIP",
      "icon": Icons.school,
      "color": Colors.blue,
    },
    {
      "id": "2",
      "name": "React Native Documentation.pdf",
      "type": "Document",
      "size": 15.8,
      "downloaded": 12.3,
      "status": "Downloading",
      "speed": "2.1 MB/s",
      "timeRemaining": "1m 42s",
      "url": "https://example.com/react-native-docs.pdf",
      "downloadPath": "/Downloads/Documents/",
      "dateAdded": "2024-01-16",
      "dateCompleted": null,
      "category": "Documentation",
      "format": "PDF",
      "icon": Icons.description,
      "color": Colors.red,
    },
    {
      "id": "3",
      "name": "Node.js Tutorial Series",
      "type": "Video",
      "size": 1.2,
      "downloaded": 0.8,
      "status": "Paused",
      "speed": "0 MB/s",
      "timeRemaining": "Paused",
      "url": "https://example.com/nodejs-tutorial.mp4",
      "downloadPath": "/Downloads/Videos/",
      "dateAdded": "2024-01-14",
      "dateCompleted": null,
      "category": "Education",
      "format": "MP4",
      "icon": Icons.play_circle,
      "color": Colors.green,
    },
    {
      "id": "4",
      "name": "Python Libraries Collection.tar.gz",
      "type": "Archive",
      "size": 856.3,
      "downloaded": 234.1,
      "status": "Downloading",
      "speed": "5.8 MB/s",
      "timeRemaining": "1h 48m",
      "url": "https://example.com/python-libs.tar.gz",
      "downloadPath": "/Downloads/Software/",
      "dateAdded": "2024-01-16",
      "dateCompleted": null,
      "category": "Software",
      "format": "TAR.GZ",
      "icon": Icons.code,
      "color": Colors.orange,
    },
    {
      "id": "5",
      "name": "Design System Templates.sketch",
      "type": "Design",
      "size": 45.6,
      "downloaded": 23.2,
      "status": "Failed",
      "speed": "0 MB/s",
      "timeRemaining": "Failed",
      "url": "https://example.com/design-templates.sketch",
      "downloadPath": "/Downloads/Design/",
      "dateAdded": "2024-01-13",
      "dateCompleted": null,
      "category": "Design",
      "format": "SKETCH",
      "icon": Icons.palette,
      "color": Colors.purple,
    },
    {
      "id": "6",
      "name": "Database Backup.sql",
      "type": "Database",
      "size": 128.7,
      "downloaded": 128.7,
      "status": "Completed",
      "speed": "0 MB/s",
      "timeRemaining": "Completed",
      "url": "https://example.com/db-backup.sql",
      "downloadPath": "/Downloads/Backups/",
      "dateAdded": "2024-01-12",
      "dateCompleted": "2024-01-12",
      "category": "Database",
      "format": "SQL",
      "icon": Icons.storage,
      "color": Colors.teal,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Education", "value": "Education"},
    {"label": "Documentation", "value": "Documentation"},
    {"label": "Software", "value": "Software"},
    {"label": "Design", "value": "Design"},
    {"label": "Database", "value": "Database"},
  ];

  List<Map<String, dynamic>> formats = [
    {"label": "All", "value": "All"},
    {"label": "PDF", "value": "PDF"},
    {"label": "ZIP", "value": "ZIP"},
    {"label": "MP4", "value": "MP4"},
    {"label": "TAR.GZ", "value": "TAR.GZ"},
    {"label": "SKETCH", "value": "SKETCH"},
    {"label": "SQL", "value": "SQL"},
  ];

  List<Map<String, dynamic>> get filteredDownloads {
    return downloads.where((download) {
      bool matchesSearch = download["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || download["category"] == selectedCategory;
      bool matchesFormat = selectedFormat == "All" || download["format"] == selectedFormat;
      
      bool matchesStatus = false;
      if (download["status"] == "Completed" && showCompleted) matchesStatus = true;
      if (download["status"] == "Downloading" && showInProgress) matchesStatus = true;
      if (download["status"] == "Paused" && showPaused) matchesStatus = true;
      if (download["status"] == "Failed" && showFailed) matchesStatus = true;

      return matchesSearch && matchesCategory && matchesFormat && matchesStatus;
    }).toList();
  }

  double get totalDownloadSize {
    return downloads.fold(0.0, (sum, download) => sum + (download["size"] as double));
  }

  double get totalDownloadedSize {
    return downloads.fold(0.0, (sum, download) => sum + (download["downloaded"] as double));
  }

  int get activeDownloads {
    return downloads.where((d) => d["status"] == "Downloading").length;
  }

  int get completedDownloads {
    return downloads.where((d) => d["status"] == "Completed").length;
  }

  void _pauseDownload(String id) {
    setState(() {
      int index = downloads.indexWhere((d) => d["id"] == id);
      if (index != -1 && downloads[index]["status"] == "Downloading") {
        downloads[index]["status"] = "Paused";
        downloads[index]["speed"] = "0 MB/s";
        downloads[index]["timeRemaining"] = "Paused";
      }
    });
    ss("Download paused");
  }

  void _resumeDownload(String id) {
    setState(() {
      int index = downloads.indexWhere((d) => d["id"] == id);
      if (index != -1 && downloads[index]["status"] == "Paused") {
        downloads[index]["status"] = "Downloading";
        downloads[index]["speed"] = "1.5 MB/s";
        downloads[index]["timeRemaining"] = "5m 30s";
      }
    });
    ss("Download resumed");
  }

  void _cancelDownload(String id) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this download?");
    if (isConfirmed) {
      setState(() {
        downloads.removeWhere((d) => d["id"] == id);
      });
      ss("Download cancelled");
    }
  }

  void _retryDownload(String id) {
    setState(() {
      int index = downloads.indexWhere((d) => d["id"] == id);
      if (index != -1 && downloads[index]["status"] == "Failed") {
        downloads[index]["status"] = "Downloading";
        downloads[index]["speed"] = "1.2 MB/s";
        downloads[index]["timeRemaining"] = "8m 45s";
      }
    });
    ss("Download restarted");
  }

  void _openFile(String id) {
    final download = downloads.firstWhere((d) => d["id"] == id);
    if (download["status"] == "Completed") {
      si("Opening ${download["name"]}");
    }
  }

  void _showDownloadDetails(Map<String, dynamic> download) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Icon(
                  download["icon"] as IconData,
                  color: download["color"] as Color,
                  size: 32,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${download["name"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            _buildDetailRow("Status", download["status"]),
            _buildDetailRow("Size", "${(download["size"] as double).toStringAsFixed(1)} GB"),
            _buildDetailRow("Downloaded", "${(download["downloaded"] as double).toStringAsFixed(1)} GB"),
            _buildDetailRow("Speed", download["speed"]),
            _buildDetailRow("Time Remaining", download["timeRemaining"]),
            _buildDetailRow("Category", download["category"]),
            _buildDetailRow("Format", download["format"]),
            _buildDetailRow("Download Path", download["downloadPath"]),
            _buildDetailRow("Date Added", download["dateAdded"]),
            if (download["dateCompleted"] != null)
              _buildDetailRow("Date Completed", download["dateCompleted"]),
            SizedBox(height: spLg),
            Text(
              "Download URL",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spXs),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Text(
                "${download["url"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addNewDownload() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Add New Download",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            QTextField(
              label: "Download URL",
              value: "",
              hint: "Enter the URL to download",
              onChanged: (value) {},
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "File Name (Optional)",
              value: "",
              hint: "Custom file name",
              onChanged: (value) {},
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Category",
              items: categories,
              value: "Education",
              onChanged: (value, label) {},
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Download Path",
              value: "/Downloads/",
              hint: "Choose download location",
              onChanged: (value) {},
            ),
            SizedBox(height: spLg),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    color: disabledColor,
                    size: bs.md,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Start Download",
                    size: bs.md,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Download started");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Manager"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewDownload,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => si("Download settings"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.download, color: primaryColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "$activeDownloads",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "$completedDownloads",
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
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.storage, color: infoColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${totalDownloadedSize.toStringAsFixed(1)}GB",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Downloaded",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search Downloads",
                    value: searchQuery,
                    hint: "Search by name or type",
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
                          label: "Format",
                          items: formats,
                          value: selectedFormat,
                          onChanged: (value, label) {
                            selectedFormat = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Status Filter",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Completed",
                              "value": "completed",
                              "checked": showCompleted,
                            }
                          ],
                          value: showCompleted ? [{"label": "Completed", "value": "completed", "checked": true}] : [],
                          onChanged: (values, ids) {
                            showCompleted = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "In Progress",
                              "value": "progress",
                              "checked": showInProgress,
                            }
                          ],
                          value: showInProgress ? [{"label": "In Progress", "value": "progress", "checked": true}] : [],
                          onChanged: (values, ids) {
                            showInProgress = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Paused",
                              "value": "paused",
                              "checked": showPaused,
                            }
                          ],
                          value: showPaused ? [{"label": "Paused", "value": "paused", "checked": true}] : [],
                          onChanged: (values, ids) {
                            showPaused = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Failed",
                              "value": "failed",
                              "checked": showFailed,
                            }
                          ],
                          value: showFailed ? [{"label": "Failed", "value": "failed", "checked": true}] : [],
                          onChanged: (values, ids) {
                            showFailed = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Downloads List
            Text(
              "Downloads (${filteredDownloads.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...filteredDownloads.map((download) {
              double progress = (download["downloaded"] as double) / (download["size"] as double);
              Color statusColor;
              switch (download["status"]) {
                case "Completed":
                  statusColor = successColor;
                  break;
                case "Downloading":
                  statusColor = primaryColor;
                  break;
                case "Paused":
                  statusColor = warningColor;
                  break;
                case "Failed":
                  statusColor = dangerColor;
                  break;
                default:
                  statusColor = disabledBoldColor;
              }

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          download["icon"] as IconData,
                          color: download["color"] as Color,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${download["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${download["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: statusColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${download["category"]} • ${download["format"]}",
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
                        PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert, color: disabledBoldColor, size: 20),
                          onSelected: (value) {
                            switch (value) {
                              case 'details':
                                _showDownloadDetails(download);
                                break;
                              case 'pause':
                                _pauseDownload(download["id"]);
                                break;
                              case 'resume':
                                _resumeDownload(download["id"]);
                                break;
                              case 'retry':
                                _retryDownload(download["id"]);
                                break;
                              case 'cancel':
                                _cancelDownload(download["id"]);
                                break;
                              case 'open':
                                _openFile(download["id"]);
                                break;
                            }
                          },
                          itemBuilder: (context) {
                            List<PopupMenuEntry<String>> items = [
                              PopupMenuItem(value: 'details', child: Text('View Details')),
                            ];

                            if (download["status"] == "Downloading") {
                              items.add(PopupMenuItem(value: 'pause', child: Text('Pause')));
                            }
                            if (download["status"] == "Paused") {
                              items.add(PopupMenuItem(value: 'resume', child: Text('Resume')));
                            }
                            if (download["status"] == "Failed") {
                              items.add(PopupMenuItem(value: 'retry', child: Text('Retry')));
                            }
                            if (download["status"] == "Completed") {
                              items.add(PopupMenuItem(value: 'open', child: Text('Open File')));
                            }
                            if (download["status"] != "Completed") {
                              items.add(PopupMenuItem(value: 'cancel', child: Text('Cancel')));
                            }

                            return items;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${(download["downloaded"] as double).toStringAsFixed(1)} GB / ${(download["size"] as double).toStringAsFixed(1)} GB",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${(progress * 100).toInt()}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: progress,
                                backgroundColor: disabledColor.withAlpha(50),
                                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${download["speed"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${download["timeRemaining"]}",
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
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredDownloads.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.download_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Downloads Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Start downloading files or adjust your filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Add Download",
                      size: bs.md,
                      onPressed: _addNewDownload,
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
