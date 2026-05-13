import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDownload5View extends StatefulWidget {
  @override
  State<GrlDownload5View> createState() => _GrlDownload5ViewState();
}

class _GrlDownload5ViewState extends State<GrlDownload5View> {
  bool loading = false;
  int selectedTabIndex = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> recentDownloads = [
    {
      "id": 1,
      "title": "Project Proposal Template",
      "type": "DOCX",
      "size": "1.2 MB",
      "downloadDate": "2024-12-20",
      "progress": 100,
      "status": "Completed",
      "thumbnail": "https://picsum.photos/60/60?random=1&keyword=document",
      "location": "/Downloads/Documents/"
    },
    {
      "id": 2,
      "title": "Marketing Assets Bundle",
      "type": "ZIP",
      "size": "34.5 MB",
      "downloadDate": "2024-12-19",
      "progress": 85,
      "status": "Downloading",
      "thumbnail": "https://picsum.photos/60/60?random=2&keyword=marketing",
      "location": "/Downloads/Assets/"
    },
    {
      "id": 3,
      "title": "Financial Report Q4",
      "type": "PDF",
      "size": "5.8 MB",
      "downloadDate": "2024-12-18",
      "progress": 100,
      "status": "Completed",
      "thumbnail": "https://picsum.photos/60/60?random=3&keyword=finance",
      "location": "/Downloads/Reports/"
    },
    {
      "id": 4,
      "title": "Training Video Series",
      "type": "MP4",
      "size": "456.2 MB",
      "downloadDate": "2024-12-17",
      "progress": 45,
      "status": "Paused",
      "thumbnail": "https://picsum.photos/60/60?random=4&keyword=video",
      "location": "/Downloads/Videos/"
    }
  ];

  List<Map<String, dynamic>> popularDownloads = [
    {
      "id": 1,
      "title": "Design System Guidelines",
      "type": "PDF",
      "size": "8.9 MB",
      "downloads": 2840,
      "rating": 4.8,
      "category": "Design",
      "thumbnail": "https://picsum.photos/80/80?random=5&keyword=design"
    },
    {
      "id": 2,
      "title": "Business Plan Template",
      "type": "DOCX",
      "size": "2.1 MB",
      "downloads": 1967,
      "rating": 4.6,
      "category": "Business",
      "thumbnail": "https://picsum.photos/80/80?random=6&keyword=business"
    },
    {
      "id": 3,
      "title": "Code Style Guide",
      "type": "PDF",
      "size": "3.4 MB",
      "downloads": 1523,
      "rating": 4.9,
      "category": "Development",
      "thumbnail": "https://picsum.photos/80/80?random=7&keyword=code"
    },
    {
      "id": 4,
      "title": "Brand Identity Kit",
      "type": "ZIP",
      "size": "67.8 MB",
      "downloads": 1298,
      "rating": 4.7,
      "category": "Branding",
      "thumbnail": "https://picsum.photos/80/80?random=8&keyword=brand"
    },
    {
      "id": 5,
      "title": "Analytics Dashboard Template",
      "type": "FIGMA",
      "size": "12.3 MB",
      "downloads": 1156,
      "rating": 4.5,
      "category": "Analytics",
      "thumbnail": "https://picsum.photos/80/80?random=9&keyword=analytics"
    }
  ];

  Future<void> _pauseDownload(Map<String, dynamic> item) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    item["status"] = "Paused";
    setState(() {});
    si("Download paused");
  }

  Future<void> _resumeDownload(Map<String, dynamic> item) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    item["status"] = "Downloading";
    setState(() {});
    si("Download resumed");
  }

  Future<void> _cancelDownload(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this download?");
    if (isConfirmed) {
      recentDownloads.removeWhere((download) => download["id"] == item["id"]);
      setState(() {});
      ss("Download cancelled");
    }
  }

  Future<void> _downloadPopularItem(Map<String, dynamic> item) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Started downloading ${item["title"]}");
  }

  Color _getProgressColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Downloading":
        return infoColor;
      case "Paused":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildRecentDownloadsTab() {
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
                  label: "Search recent downloads...",
                  value: searchQuery,
                  hint: "Search by filename",
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
                  si("Searching downloads");
                },
              ),
            ],
          ),

          // Download Progress Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.download,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Download Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${recentDownloads.where((item) => item["status"] == "Downloading").length} active • ${recentDownloads.where((item) => item["status"] == "Completed").length} completed",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Recent Downloads List
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
            children: recentDownloads.map((item) {
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
                                "${item["location"]}",
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
                            color: _getProgressColor(item["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getProgressColor(item["status"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    if (item["status"] != "Completed") ...[
                      SizedBox(height: spSm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${item["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getProgressColor(item["status"] as String),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${DateTime.parse(item["downloadDate"] as String).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: (item["progress"] as int) / 100,
                            backgroundColor: disabledColor.withAlpha(30),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getProgressColor(item["status"] as String),
                            ),
                          ),
                        ],
                      ),
                    ],

                    SizedBox(height: spSm),
                    Row(
                      children: [
                        if (item["status"] == "Downloading") ...[
                          Expanded(
                            child: QButton(
                              label: "Pause",
                              size: bs.sm,
                              icon: Icons.pause,
                              onPressed: () => _pauseDownload(item),
                            ),
                          ),
                        ] else if (item["status"] == "Paused") ...[
                          Expanded(
                            child: QButton(
                              label: "Resume",
                              size: bs.sm,
                              icon: Icons.play_arrow,
                              onPressed: () => _resumeDownload(item),
                            ),
                          ),
                        ] else ...[
                          Expanded(
                            child: QButton(
                              label: "Open",
                              size: bs.sm,
                              icon: Icons.open_in_new,
                              onPressed: () {
                                si("Opening ${item["title"]}");
                              },
                            ),
                          ),
                        ],
                        
                        if (item["status"] != "Completed") ...[
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Cancel",
                              size: bs.sm,
                              icon: Icons.cancel,
                              onPressed: () => _cancelDownload(item),
                            ),
                          ),
                        ],
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

  Widget _buildPopularDownloadsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Downloads Header
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Most Popular Downloads",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          // Popular Downloads Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: popularDownloads.map((item) {
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
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${item["thumbnail"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: infoColor,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${item["type"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${item["size"]}",
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
                          "${((item["downloads"] as int) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
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
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Download",
                        size: bs.sm,
                        icon: Icons.download,
                        onPressed: () => _downloadPopularItem(item),
                      ),
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
      title: "Downloads",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Recent", icon: Icon(Icons.history)),
        Tab(text: "Popular", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildRecentDownloadsTab(),
        _buildPopularDownloadsTab(),
      ],
    );
  }
}
