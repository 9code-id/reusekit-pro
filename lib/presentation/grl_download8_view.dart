import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDownload8View extends StatefulWidget {
  @override
  State<GrlDownload8View> createState() => _GrlDownload8ViewState();
}

class _GrlDownload8ViewState extends State<GrlDownload8View> {
  bool loading = false;
  String selectedCategory = "All";
  String selectedSize = "All Sizes";
  String selectedDate = "All Time";
  String searchQuery = "";
  
  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All", "value": "All"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Media", "value": "Media"},
    {"label": "Software", "value": "Software"},
    {"label": "Archives", "value": "Archives"},
    {"label": "Others", "value": "Others"},
  ];

  List<Map<String, dynamic>> sizeFilters = [
    {"label": "All Sizes", "value": "All Sizes"},
    {"label": "Small (< 10 MB)", "value": "Small"},
    {"label": "Medium (10-100 MB)", "value": "Medium"},
    {"label": "Large (> 100 MB)", "value": "Large"},
  ];

  List<Map<String, dynamic>> dateFilters = [
    {"label": "All Time", "value": "All Time"},
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> downloadArchive = [
    {
      "id": 1,
      "title": "Complete Business Strategy Guide",
      "description": "Comprehensive guide covering all aspects of business strategy development",
      "type": "PDF",
      "size": "25.4 MB",
      "category": "Documents",
      "downloadDate": "2024-12-20",
      "downloadCount": 1,
      "fileVersion": "2.1",
      "author": "Business Experts Inc.",
      "tags": ["Business", "Strategy", "Guide"],
      "rating": 4.8,
      "thumbnail": "https://picsum.photos/80/80?random=1&keyword=business",
      "verified": true
    },
    {
      "id": 2,
      "title": "Design Assets Bundle Pro",
      "description": "Professional design assets including icons, illustrations, and templates",
      "type": "ZIP",
      "size": "234.7 MB",
      "category": "Media",
      "downloadDate": "2024-12-19",
      "downloadCount": 3,
      "fileVersion": "1.5",
      "author": "Design Studio",
      "tags": ["Design", "Assets", "Templates"],
      "rating": 4.9,
      "thumbnail": "https://picsum.photos/80/80?random=2&keyword=design",
      "verified": true
    },
    {
      "id": 3,
      "title": "Development Tools Suite",
      "description": "Complete set of development tools for modern software development",
      "type": "EXE",
      "size": "567.2 MB",
      "category": "Software",
      "downloadDate": "2024-12-18",
      "downloadCount": 1,
      "fileVersion": "3.0",
      "author": "DevTools Corp",
      "tags": ["Development", "Tools", "Software"],
      "rating": 4.7,
      "thumbnail": "https://picsum.photos/80/80?random=3&keyword=software",
      "verified": true
    },
    {
      "id": 4,
      "title": "Marketing Campaign Templates",
      "description": "Ready-to-use marketing campaign templates for various industries",
      "type": "ZIP",
      "size": "89.3 MB",
      "category": "Documents",
      "downloadDate": "2024-12-17",
      "downloadCount": 2,
      "fileVersion": "1.2",
      "author": "Marketing Pro",
      "tags": ["Marketing", "Templates", "Campaign"],
      "rating": 4.6,
      "thumbnail": "https://picsum.photos/80/80?random=4&keyword=marketing",
      "verified": false
    },
    {
      "id": 5,
      "title": "Video Production Toolkit",
      "description": "Complete toolkit for video production including effects and transitions",
      "type": "ZIP",
      "size": "1.2 GB",
      "category": "Media",
      "downloadDate": "2024-12-16",
      "downloadCount": 1,
      "fileVersion": "2.3",
      "author": "Video Pro Studios",
      "tags": ["Video", "Production", "Effects"],
      "rating": 4.8,
      "thumbnail": "https://picsum.photos/80/80?random=5&keyword=video",
      "verified": true
    },
    {
      "id": 6,
      "title": "Data Analysis Scripts",
      "description": "Python scripts for advanced data analysis and visualization",
      "type": "ZIP",
      "size": "15.7 MB",
      "category": "Software",
      "downloadDate": "2024-12-15",
      "downloadCount": 4,
      "fileVersion": "1.8",
      "author": "Data Science Hub",
      "tags": ["Data", "Analysis", "Python"],
      "rating": 4.9,
      "thumbnail": "https://picsum.photos/80/80?random=6&keyword=data",
      "verified": true
    }
  ];

  List<Map<String, dynamic>> get filteredArchive {
    List<Map<String, dynamic>> filtered = downloadArchive;
    
    // Category filter
    if (selectedCategory != "All") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }
    
    // Size filter  
    if (selectedSize != "All Sizes") {
      filtered = filtered.where((item) {
        double sizeMB = double.parse((item["size"] as String).split(" ")[0]);
        switch (selectedSize) {
          case "Small":
            return sizeMB < 10;
          case "Medium":
            return sizeMB >= 10 && sizeMB <= 100;
          case "Large":
            return sizeMB > 100;
          default:
            return true;
        }
      }).toList();
    }
    
    // Search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) => 
        (item["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (item["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (item["tags"] as List<String>).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
    }
    
    return filtered;
  }

  Future<void> _redownloadFile(Map<String, dynamic> item) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    item["downloadCount"] = (item["downloadCount"] as int) + 1;
    setState(() {});
    ss("${item["title"]} re-downloaded successfully");
  }

  Future<void> _shareFile(Map<String, dynamic> item) async {
    si("Sharing ${item["title"]}");
  }

  Future<void> _deleteFromArchive(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Are you sure you want to remove this item from your archive?");
    if (isConfirmed) {
      downloadArchive.removeWhere((archive) => archive["id"] == item["id"]);
      setState(() {});
      ss("Item removed from archive");
    }
  }

  Future<void> _exportArchive() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Archive exported successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Archive"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportArchive,
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              si("More options");
            },
          ),
        ],
      ),
      body: loading ? 
        Center(child: CircularProgressIndicator()) : 
        SingleChildScrollView(
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
                      label: "Search archive...",
                      value: searchQuery,
                      hint: "Search by title, description, or tags",
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
                      si("Searching archive");
                    },
                  ),
                ],
              ),

              // Filter Controls
              Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryFilters,
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
                          label: "File Size",
                          items: sizeFilters,
                          value: selectedSize,
                          onChanged: (value, label) {
                            selectedSize = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Date Range",
                    items: dateFilters,
                    value: selectedDate,
                    onChanged: (value, label) {
                      selectedDate = value;
                      setState(() {});
                    },
                  ),
                ],
              ),

              // Archive Statistics
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
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
                          Icons.archive,
                          color: primaryColor,
                          size: 28,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Archive Overview",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                                "${downloadArchive.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
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
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${(downloadArchive.map((item) => item["downloadCount"] as int).reduce((a, b) => a + b))}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Downloads",
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
                                "${downloadArchive.where((item) => item["verified"] == true).length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Verified",
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

              // Results Header
              Row(
                children: [
                  Text(
                    "Archive Files",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${filteredArchive.length} files",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),

              // Archive Files List
              Column(
                spacing: spSm,
                children: filteredArchive.map((item) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: item["verified"] == true ? 
                        Border.all(color: successColor.withAlpha(30), width: 1) : 
                        null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${item["title"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      if (item["verified"] == true) ...[
                                        Icon(
                                          Icons.verified,
                                          size: 20,
                                          color: successColor,
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${item["type"]} • ${item["size"]} • v${item["fileVersion"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "by ${item["author"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${item["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${item["rating"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(
                              Icons.download,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${item["downloadCount"]} downloads",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${DateTime.parse(item["downloadDate"] as String).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Wrap(
                          spacing: spXs,
                          children: (item["tags"] as List<String>).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: infoColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Download",
                                size: bs.sm,
                                icon: Icons.download,
                                onPressed: () => _redownloadFile(item),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Share",
                                size: bs.sm,
                                icon: Icons.share,
                                onPressed: () => _shareFile(item),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Remove",
                                size: bs.sm,
                                icon: Icons.delete,
                                onPressed: () => _deleteFromArchive(item),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Archive Actions
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
                      "Archive Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Export Archive",
                            size: bs.sm,
                            icon: Icons.file_download,
                            onPressed: _exportArchive,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Clear All",
                            size: bs.sm,
                            icon: Icons.clear_all,
                            onPressed: () async {
                              bool isConfirmed = await confirm("Are you sure you want to clear all archive files?");
                              if (isConfirmed) {
                                downloadArchive.clear();
                                setState(() {});
                                ss("Archive cleared");
                              }
                            },
                          ),
                        ),
                      ],
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
