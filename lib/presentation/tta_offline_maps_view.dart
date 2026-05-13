import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaOfflineMapsView extends StatefulWidget {
  const TtaOfflineMapsView({super.key});

  @override
  State<TtaOfflineMapsView> createState() => _TtaOfflineMapsViewState();
}

class _TtaOfflineMapsViewState extends State<TtaOfflineMapsView> {
  String searchQuery = "";
  String selectedRegion = "All";
  bool showDownloaded = false;

  List<Map<String, dynamic>> regions = [
    {"label": "All", "value": "All"},
    {"label": "Europe", "value": "Europe"},
    {"label": "Asia", "value": "Asia"},
    {"label": "North America", "value": "North America"},
    {"label": "South America", "value": "South America"},
    {"label": "Africa", "value": "Africa"},
    {"label": "Oceania", "value": "Oceania"},
  ];

  List<Map<String, dynamic>> offlineMaps = [
    {
      "name": "Paris, France",
      "region": "Europe",
      "size": "45.2 MB",
      "downloaded": true,
      "downloadDate": "2 days ago",
      "lastUpdate": "1 week ago",
      "coverage": "City Center & Suburbs",
      "features": ["Navigation", "POI", "Transit"]
    },
    {
      "name": "Tokyo, Japan", 
      "region": "Asia",
      "size": "67.8 MB",
      "downloaded": true,
      "downloadDate": "5 days ago",
      "lastUpdate": "3 days ago",
      "coverage": "Metropolitan Area",
      "features": ["Navigation", "POI", "Transit", "3D Buildings"]
    },
    {
      "name": "New York, USA",
      "region": "North America",
      "size": "52.4 MB",
      "downloaded": false,
      "lastUpdate": "2 days ago",
      "coverage": "Manhattan & Brooklyn",
      "features": ["Navigation", "POI", "Transit", "Traffic"]
    },
    {
      "name": "London, UK",
      "region": "Europe", 
      "size": "38.9 MB",
      "downloaded": false,
      "lastUpdate": "1 day ago",
      "coverage": "Greater London",
      "features": ["Navigation", "POI", "Transit"]
    },
    {
      "name": "Barcelona, Spain",
      "region": "Europe",
      "size": "29.6 MB", 
      "downloaded": true,
      "downloadDate": "1 week ago",
      "lastUpdate": "4 days ago",
      "coverage": "City & Coastal Areas",
      "features": ["Navigation", "POI", "Beaches"]
    },
    {
      "name": "Bangkok, Thailand",
      "region": "Asia",
      "size": "41.3 MB",
      "downloaded": false,
      "lastUpdate": "2 days ago",
      "coverage": "Central Bangkok",
      "features": ["Navigation", "POI", "Transit", "Markets"]
    },
  ];

  List<Map<String, dynamic>> get filteredMaps {
    List<Map<String, dynamic>> filtered = offlineMaps;

    if (selectedRegion != "All") {
      filtered = filtered.where((map) => map["region"] == selectedRegion).toList();
    }

    if (showDownloaded) {
      filtered = filtered.where((map) => map["downloaded"] == true).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((map) => 
        map["name"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  void _downloadMap(Map<String, dynamic> map) {
    showLoading();
    
    // Simulate download
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      setState(() {
        map["downloaded"] = true;
        map["downloadDate"] = "Just now";
      });
      ss("Map downloaded successfully");
    });
  }

  void _deleteMap(Map<String, dynamic> map) async {
    bool isConfirmed = await confirm("Delete this offline map?");
    if (isConfirmed) {
      setState(() {
        map["downloaded"] = false;
        map.remove("downloadDate");
      });
      ss("Map deleted");
    }
  }

  double get totalDownloadedSize {
    return filteredMaps
        .where((map) => map["downloaded"] == true)
        .map((map) => double.tryParse(map["size"].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0)
        .fold(0.0, (sum, size) => sum + size);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Maps"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Storage Info Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.storage,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Storage Usage",
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
                              "Downloaded Maps",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${filteredMaps.where((map) => map["downloaded"] == true).length} maps",
                              style: TextStyle(
                                fontSize: 18,
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
                          spacing: spXs,
                          children: [
                            Text(
                              "Total Size",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${totalDownloadedSize.toStringAsFixed(1)} MB",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search maps...",
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

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Region",
                    items: regions,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Downloaded Only",
                        "value": true,
                        "checked": showDownloaded,
                      }
                    ],
                    value: showDownloaded ? [{"label": "Downloaded Only", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      showDownloaded = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Maps List
            Text(
              "Available Maps (${filteredMaps.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: List.generate(filteredMaps.length, (index) {
                final map = filteredMaps[index];
                bool isDownloaded = map["downloaded"] as bool;
                
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: isDownloaded 
                      ? Border.all(color: successColor.withAlpha(100))
                      : null,
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${map["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  spacing: spSm,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${map["region"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${map["size"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isDownloaded) ...[
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(30),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: successColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ],
                      ),

                      Text(
                        "Coverage: ${map["coverage"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      QHorizontalScroll(
                        children: List.generate((map["features"] as List).length, (featureIndex) {
                          final feature = (map["features"] as List)[featureIndex];
                          
                          return Container(
                            margin: EdgeInsets.only(right: spXs),
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$feature",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          );
                        }),
                      ),

                      if (isDownloaded) ...[
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXxs,
                                children: [
                                  Text(
                                    "Downloaded: ${map["downloadDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Last Update: ${map["lastUpdate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              label: "Delete",
                              size: bs.sm,
                              onPressed: () => _deleteMap(map),
                            ),
                          ],
                        ),
                      ] else ...[
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Last Update: ${map["lastUpdate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            QButton(
                              label: "Download",
                              size: bs.sm,
                              onPressed: () => _downloadMap(map),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ),

            // Download Tips
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Download Tips",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Download maps while connected to Wi-Fi to save mobile data\n"
                    "• Maps automatically update when connected to internet\n"
                    "• Downloaded maps work completely offline for navigation\n"
                    "• Regular updates ensure you have the latest roads and POIs",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      height: 1.5,
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
