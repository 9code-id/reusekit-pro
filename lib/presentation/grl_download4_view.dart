import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDownload4View extends StatefulWidget {
  @override
  State<GrlDownload4View> createState() => _GrlDownload4ViewState();
}

class _GrlDownload4ViewState extends State<GrlDownload4View> {
  bool loading = false;
  String selectedCategory = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> downloadCategories = [
    {"label": "All", "value": "All"},
    {"label": "Documents", "value": "Documents"},
    {"label": "Images", "value": "Images"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Audio", "value": "Audio"},
    {"label": "Software", "value": "Software"},
  ];

  List<Map<String, dynamic>> downloadItems = [
    {
      "id": 1,
      "title": "Annual Report 2024",
      "type": "PDF Document",
      "size": "2.4 MB",
      "category": "Documents",
      "downloadCount": 1250,
      "date": "2024-12-15",
      "status": "Available",
      "thumbnail": "https://picsum.photos/80/80?random=1&keyword=document",
      "description": "Comprehensive annual financial report with detailed analytics",
      "tags": ["Finance", "Report", "Analytics"]
    },
    {
      "id": 2,
      "title": "Product Catalog Spring 2024",
      "type": "PDF Brochure",
      "size": "8.7 MB",
      "category": "Documents",
      "downloadCount": 890,
      "date": "2024-11-20",
      "status": "Available",
      "thumbnail": "https://picsum.photos/80/80?random=2&keyword=catalog",
      "description": "Complete product catalog featuring new spring collection",
      "tags": ["Catalog", "Products", "Spring"]
    },
    {
      "id": 3,
      "title": "Company Profile Video",
      "type": "MP4 Video",
      "size": "45.2 MB",
      "category": "Videos",
      "downloadCount": 567,
      "date": "2024-10-30",
      "status": "Available",
      "thumbnail": "https://picsum.photos/80/80?random=3&keyword=video",
      "description": "Professional company introduction and overview video",
      "tags": ["Company", "Introduction", "Professional"]
    },
    {
      "id": 4,
      "title": "Software Installation Guide",
      "type": "ZIP Archive",
      "size": "125.8 MB",
      "category": "Software",
      "downloadCount": 2340,
      "date": "2024-12-01",
      "status": "Available",
      "thumbnail": "https://picsum.photos/80/80?random=4&keyword=software",
      "description": "Complete software package with installation instructions",
      "tags": ["Software", "Installation", "Guide"]
    },
    {
      "id": 5,
      "title": "Brand Assets Collection",
      "type": "ZIP Images",
      "size": "67.3 MB",
      "category": "Images",
      "downloadCount": 445,
      "date": "2024-11-15",
      "status": "Available",
      "thumbnail": "https://picsum.photos/80/80?random=5&keyword=brand",
      "description": "Official brand logos, colors, and design assets",
      "tags": ["Brand", "Logo", "Design"]
    },
    {
      "id": 6,
      "title": "Training Audio Series",
      "type": "MP3 Audio",
      "size": "89.4 MB",
      "category": "Audio",
      "downloadCount": 723,
      "date": "2024-10-25",
      "status": "Available",
      "thumbnail": "https://picsum.photos/80/80?random=6&keyword=audio",
      "description": "Professional training audio series for skill development",
      "tags": ["Training", "Audio", "Education"]
    }
  ];

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> filtered = downloadItems;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) => 
        (item["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (item["description"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Future<void> _downloadFile(Map<String, dynamic> item) async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("${item["title"]} downloaded successfully");
  }

  Future<void> _previewFile(Map<String, dynamic> item) async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    si("Opening preview for ${item["title"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              si("Filter options");
            },
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
                      label: "Search downloads...",
                      value: searchQuery,
                      hint: "Search by title or description",
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
                      si("Searching for: $searchQuery");
                    },
                  ),
                ],
              ),

              // Category Filter
              QDropdownField(
                label: "Category",
                items: downloadCategories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),

              // Stats Card
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Downloads",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(downloadItems.map((item) => item["downloadCount"] as int).reduce((a, b) => a + b) / 1000).toStringAsFixed(1)}K",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
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
                            "Available Files",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${downloadItems.length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
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
                            "Categories",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${downloadCategories.length - 1}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Section Header
              Row(
                children: [
                  Text(
                    "Available Downloads",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${filteredItems.length} files",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),

              // Download Items List
              Column(
                spacing: spSm,
                children: filteredItems.map((item) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
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
                                      fontWeight: FontWeight.w500,
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
                              Icons.download,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${(item["downloadCount"] as int).toString()} downloads",
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
                              "${DateTime.parse(item["date"] as String).dMMMy}",
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
                                label: "Preview",
                                size: bs.sm,
                                icon: Icons.visibility,
                                onPressed: () => _previewFile(item),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Download",
                                size: bs.sm,
                                icon: Icons.download,
                                onPressed: () => _downloadFile(item),
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
        ),
    );
  }
}
