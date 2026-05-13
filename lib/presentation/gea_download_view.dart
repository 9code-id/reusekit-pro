import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaDownloadView extends StatefulWidget {
  const GeaDownloadView({super.key});

  @override
  State<GeaDownloadView> createState() => _GeaDownloadViewState();
}

class _GeaDownloadViewState extends State<GeaDownloadView> {
  String selectedGame = "";
  bool isDownloading = false;
  double downloadProgress = 0.0;
  String downloadSpeed = "";
  String estimatedTime = "";
  String selectedVersion = "Latest";

  List<Map<String, dynamic>> games = [
    {
      "id": 1,
      "title": "Cyber Combat 2077",
      "size": "45.2 GB",
      "version": "1.3.2",
      "rating": 4.8,
      "downloads": 2500000,
      "category": "Action",
      "cover": "https://picsum.photos/400/600?random=1&keyword=game",
      "screenshots": [
        "https://picsum.photos/800/450?random=11&keyword=cyberpunk",
        "https://picsum.photos/800/450?random=12&keyword=futuristic",
        "https://picsum.photos/800/450?random=13&keyword=neon",
      ],
      "description": "Experience the ultimate cyberpunk adventure in a dystopian future",
      "requirements": {
        "os": "Windows 10 64-bit",
        "processor": "Intel Core i5-8400 / AMD Ryzen 5 2600",
        "memory": "12 GB RAM",
        "graphics": "NVIDIA GTX 1060 6GB / AMD RX 580 8GB",
        "storage": "70 GB available space"
      },
      "isDownloading": false,
      "isInstalled": false,
      "downloadProgress": 0.0,
    },
    {
      "id": 2,
      "title": "Fantasy Realm Quest",
      "size": "28.7 GB",
      "version": "2.1.0",
      "rating": 4.6,
      "downloads": 1800000,
      "category": "RPG",
      "cover": "https://picsum.photos/400/600?random=2&keyword=fantasy",
      "screenshots": [
        "https://picsum.photos/800/450?random=21&keyword=fantasy",
        "https://picsum.photos/800/450?random=22&keyword=dragon",
        "https://picsum.photos/800/450?random=23&keyword=castle",
      ],
      "description": "Embark on an epic fantasy adventure with magic and mythical creatures",
      "requirements": {
        "os": "Windows 10 64-bit",
        "processor": "Intel Core i3-6100 / AMD FX-6300",
        "memory": "8 GB RAM",
        "graphics": "NVIDIA GTX 750 Ti / AMD R7 260X",
        "storage": "35 GB available space"
      },
      "isDownloading": false,
      "isInstalled": true,
      "downloadProgress": 100.0,
    },
    {
      "id": 3,
      "title": "Racing Thunder",
      "size": "15.3 GB",
      "version": "1.8.5",
      "rating": 4.4,
      "downloads": 3200000,
      "category": "Racing",
      "cover": "https://picsum.photos/400/600?random=3&keyword=racing",
      "screenshots": [
        "https://picsum.photos/800/450?random=31&keyword=car",
        "https://picsum.photos/800/450?random=32&keyword=speed",
        "https://picsum.photos/800/450?random=33&keyword=track",
      ],
      "description": "High-speed racing action with realistic physics and stunning graphics",
      "requirements": {
        "os": "Windows 10 64-bit",
        "processor": "Intel Core i5-4590 / AMD Ryzen 3 1200",
        "memory": "8 GB RAM",
        "graphics": "NVIDIA GTX 960 / AMD R9 280",
        "storage": "20 GB available space"
      },
      "isDownloading": false,
      "isInstalled": false,
      "downloadProgress": 0.0,
    },
  ];

  List<Map<String, dynamic>> downloadQueue = [];

  void _startDownload(Map<String, dynamic> game) {
    setState(() {
      game["isDownloading"] = true;
      downloadQueue.add(game);
      if (downloadQueue.length == 1) {
        _simulateDownload(game);
      }
    });
    ss("Download started for ${game["title"]}");
  }

  void _simulateDownload(Map<String, dynamic> game) {
    // Simulate download progress
    setState(() {
      isDownloading = true;
      selectedGame = game["title"];
      downloadSpeed = "12.5 MB/s";
      estimatedTime = "25 minutes";
    });
  }

  void _pauseDownload(Map<String, dynamic> game) {
    setState(() {
      game["isDownloading"] = false;
      isDownloading = false;
    });
    si("Download paused for ${game["title"]}");
  }

  void _resumeDownload(Map<String, dynamic> game) {
    setState(() {
      game["isDownloading"] = true;
      isDownloading = true;
    });
    si("Download resumed for ${game["title"]}");
  }

  void _cancelDownload(Map<String, dynamic> game) {
    setState(() {
      game["isDownloading"] = false;
      game["downloadProgress"] = 0.0;
      downloadQueue.removeWhere((g) => g["id"] == game["id"]);
      isDownloading = downloadQueue.isNotEmpty;
    });
    sw("Download cancelled for ${game["title"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downloads"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('GeaDownloadSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Current Download Status
            if (isDownloading) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.download,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Downloading: $selectedGame",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          icon: Icons.pause,
                          size: bs.sm,
                          onPressed: () {
                            // Pause current download
                          },
                        ),
                      ],
                    ),
                    
                    LinearProgressIndicator(
                      value: downloadProgress / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${downloadProgress.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "$downloadSpeed • $estimatedTime left",
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

            // Download Queue
            if (downloadQueue.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Download Queue (${downloadQueue.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    ...downloadQueue.map((game) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${game["cover"]}",
                                width: 40,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${game["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${game["size"]} • ${game["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              icon: Icons.close,
                              size: bs.sm,
                              onPressed: () => _cancelDownload(game),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],

            // Available Games
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Available Games",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...games.map((game) {
                    final isInstalled = game["isInstalled"] as bool;
                    final isInQueue = downloadQueue.any((g) => g["id"] == game["id"]);
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${game["cover"]}",
                                  width: 60,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "${game["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${game["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: warningColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${game["rating"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${((game["downloads"] as int) / 1000000).toStringAsFixed(1)}M downloads",
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
                          
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${game["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${game["size"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              if (isInstalled)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "Installed",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              else if (isInQueue)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "In Queue",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              else
                                QButton(
                                  label: "Download",
                                  size: bs.sm,
                                  onPressed: () => _startDownload(game),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
