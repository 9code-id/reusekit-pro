import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDownload7View extends StatefulWidget {
  @override
  State<GrlDownload7View> createState() => _GrlDownload7ViewState();
}

class _GrlDownload7ViewState extends State<GrlDownload7View> {
  bool loading = false;
  int selectedTabIndex = 0;
  String selectedLocation = "Downloads";
  bool showHiddenFiles = false;
  String searchQuery = "";
  
  List<Map<String, dynamic>> downloadLocations = [
    {"label": "Downloads", "value": "Downloads"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Desktop", "value": "Desktop"},
    {"label": "Pictures", "value": "Pictures"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Music", "value": "Music"},
  ];

  List<Map<String, dynamic>> downloadHistory = [
    {
      "id": 1,
      "title": "Company Annual Report 2024",
      "type": "PDF",
      "size": "15.2 MB",
      "downloadDate": "2024-12-20 15:30:00",
      "location": "/Downloads/Documents/",
      "source": "company.com",
      "status": "Completed",
      "duration": "00:02:34",
      "averageSpeed": "6.2 MB/s",
      "thumbnail": "https://picsum.photos/60/60?random=1&keyword=report"
    },
    {
      "id": 2,
      "title": "Design System Kit",
      "type": "ZIP",
      "size": "89.7 MB",
      "downloadDate": "2024-12-20 14:15:00",
      "location": "/Downloads/Assets/",
      "source": "design-resources.com",
      "status": "Completed",
      "duration": "00:14:22",
      "averageSpeed": "6.4 MB/s",
      "thumbnail": "https://picsum.photos/60/60?random=2&keyword=design"
    },
    {
      "id": 3,
      "title": "Marketing Video Template",
      "type": "MP4",
      "size": "234.8 MB",
      "downloadDate": "2024-12-20 13:45:00",
      "location": "/Downloads/Videos/",
      "source": "templates.media",
      "status": "Completed",
      "duration": "00:38:15",
      "averageSpeed": "6.1 MB/s",
      "thumbnail": "https://picsum.photos/60/60?random=3&keyword=video"
    },
    {
      "id": 4,
      "title": "Software Installation Package",
      "type": "EXE",
      "size": "456.3 MB",
      "downloadDate": "2024-12-20 12:30:00",
      "location": "/Downloads/Software/",
      "source": "software.download",
      "status": "Completed",
      "duration": "01:12:45",
      "averageSpeed": "6.3 MB/s",
      "thumbnail": "https://picsum.photos/60/60?random=4&keyword=software"
    },
    {
      "id": 5,
      "title": "Project Documentation",
      "type": "DOCX",
      "size": "3.4 MB",
      "downloadDate": "2024-12-20 11:20:00",
      "location": "/Downloads/Documents/",
      "source": "project-docs.com",
      "status": "Completed",
      "duration": "00:00:45",
      "averageSpeed": "7.6 MB/s",
      "thumbnail": "https://picsum.photos/60/60?random=5&keyword=document"
    },
    {
      "id": 6,
      "title": "Audio Podcast Series",
      "type": "MP3",
      "size": "128.9 MB",
      "downloadDate": "2024-12-20 10:15:00",
      "location": "/Downloads/Audio/",
      "source": "podcast.stream",
      "status": "Completed",
      "duration": "00:20:18",
      "averageSpeed": "6.3 MB/s",
      "thumbnail": "https://picsum.photos/60/60?random=6&keyword=audio"
    }
  ];

  List<Map<String, dynamic>> fileManager = [
    {
      "name": "Annual Report 2024.pdf",
      "type": "PDF",
      "size": "15.2 MB",
      "dateModified": "2024-12-20 15:30:00",
      "isFolder": false,
      "thumbnail": "https://picsum.photos/40/40?random=11&keyword=pdf"
    },
    {
      "name": "Projects",
      "type": "Folder",
      "size": "12 items",
      "dateModified": "2024-12-20 14:45:00",
      "isFolder": true,
      "thumbnail": ""
    },
    {
      "name": "Design Assets",
      "type": "Folder",
      "size": "8 items",
      "dateModified": "2024-12-20 14:30:00",
      "isFolder": true,
      "thumbnail": ""
    },
    {
      "name": "Marketing_Video.mp4",
      "type": "MP4",
      "size": "234.8 MB",
      "dateModified": "2024-12-20 13:45:00",
      "isFolder": false,
      "thumbnail": "https://picsum.photos/40/40?random=12&keyword=video"
    },
    {
      "name": "Software_Installer.exe",
      "type": "EXE",
      "size": "456.3 MB",
      "dateModified": "2024-12-20 12:30:00",
      "isFolder": false,
      "thumbnail": "https://picsum.photos/40/40?random=13&keyword=software"
    },
    {
      "name": "Documentation.docx",
      "type": "DOCX",
      "size": "3.4 MB",
      "dateModified": "2024-12-20 11:20:00",
      "isFolder": false,
      "thumbnail": "https://picsum.photos/40/40?random=14&keyword=document"
    }
  ];

  Future<void> _deleteFile(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this file?");
    if (isConfirmed) {
      if (selectedTabIndex == 0) {
        downloadHistory.removeWhere((history) => history["id"] == item["id"]);
      } else {
        fileManager.removeWhere((file) => file["name"] == item["name"]);
      }
      setState(() {});
      ss("File deleted successfully");
    }
  }

  Future<void> _openFile(Map<String, dynamic> item) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    if (selectedTabIndex == 0) {
      si("Opening ${item["title"]}");
    } else {
      si("Opening ${item["name"]}");
    }
  }

  Future<void> _showFileInfo(Map<String, dynamic> item) async {
    si("File information displayed");
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search download history...",
                  value: searchQuery,
                  hint: "Search by filename or source",
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
                onPressed: () {
                  si("Searching history");
                },
              ),
            ],
          ),

          // Statistics Card
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [infoColor.withAlpha(20), infoColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.analytics,
                      color: infoColor,
                      size: 28,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Download Statistics",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${downloadHistory.length}",
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
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${((downloadHistory.map((item) => double.parse((item["size"] as String).split(" ")[0])).reduce((a, b) => a + b))).toStringAsFixed(1)} GB",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Size",
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
                        children: [
                          Text(
                            "6.3 MB/s",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Avg Speed",
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
              ],
            ),
          ),

          // History List
          Text(
            "Recent Downloads",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Column(
            spacing: spSm,
            children: downloadHistory.map((item) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${item["thumbnail"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${item["type"]} • ${item["size"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Source: ${item["source"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Duration",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${item["duration"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
                                  "Speed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${item["averageSpeed"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
                                  "Downloaded",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${DateTime.parse(item["downloadDate"] as String).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Open",
                            size: bs.sm,
                            icon: Icons.open_in_new,
                            onPressed: () => _openFile(item),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Info",
                            size: bs.sm,
                            icon: Icons.info,
                            onPressed: () => _showFileInfo(item),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Delete",
                            size: bs.sm,
                            icon: Icons.delete,
                            onPressed: () => _deleteFile(item),
                          ),
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
    );
  }

  Widget _buildFileManagerTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location and Options
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Location",
                  items: downloadLocations,
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  si("Refreshing file list");
                },
              ),
            ],
          ),

          // Options
          Row(
            children: [
              Text(
                "Show hidden files",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Switch(
                value: showHiddenFiles,
                onChanged: (value) {
                  showHiddenFiles = value;
                  setState(() {});
                },
              ),
            ],
          ),

          // File List Header
          Row(
            children: [
              Text(
                "Files in $selectedLocation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${fileManager.length} items",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // File List
          Column(
            spacing: spXs,
            children: fileManager.map((item) {
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
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusXs),
                        color: item["isFolder"] as bool ? primaryColor.withAlpha(20) : disabledColor.withAlpha(20),
                      ),
                      child: item["isFolder"] as bool ? 
                        Icon(
                          Icons.folder,
                          color: primaryColor,
                          size: 24,
                        ) : 
                        item["thumbnail"] != "" ? 
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${item["thumbnail"]}",
                              fit: BoxFit.cover,
                            ),
                          ) : 
                          Icon(
                            Icons.insert_drive_file,
                            color: disabledBoldColor,
                            size: 24,
                          ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${item["type"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "•",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${item["size"]}",
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${DateTime.parse(item["dateModified"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => _openFile(item),
                              child: Icon(
                                Icons.open_in_new,
                                size: 20,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () => _showFileInfo(item),
                              child: Icon(
                                Icons.info_outline,
                                size: 20,
                                color: infoColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () => _deleteFile(item),
                              child: Icon(
                                Icons.delete_outline,
                                size: 20,
                                color: dangerColor,
                              ),
                            ),
                          ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Download Manager",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Files", icon: Icon(Icons.folder)),
      ],
      tabChildren: [
        _buildHistoryTab(),
        _buildFileManagerTab(),
      ],
    );
  }
}
