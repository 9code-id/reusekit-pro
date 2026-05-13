import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmEquipmentManualsView extends StatefulWidget {
  const FsmEquipmentManualsView({super.key});

  @override
  State<FsmEquipmentManualsView> createState() => _FsmEquipmentManualsViewState();
}

class _FsmEquipmentManualsViewState extends State<FsmEquipmentManualsView> {
  List<Map<String, dynamic>> manuals = [
    {
      "id": "MAN001",
      "title": "Industrial Generator Model X200 - Service Manual",
      "equipmentId": "EQ001",
      "equipmentName": "Industrial Generator Model X200",
      "manufacturer": "PowerTech Industries",
      "version": "v2.1",
      "language": "English",
      "fileType": "PDF",
      "fileSize": "15.2 MB",
      "pages": 248,
      "category": "Service Manual",
      "lastUpdated": "2024-05-15",
      "downloadCount": 45,
      "tags": ["Maintenance", "Troubleshooting", "Parts", "Installation"],
      "description": "Complete service and maintenance manual including troubleshooting guides, parts diagrams, and installation procedures.",
      "thumbnail": "https://picsum.photos/100/140?random=1&keyword=manual",
      "isDownloaded": true,
      "isFavorite": false
    },
    {
      "id": "MAN002",
      "title": "HVAC System Pro Series 500 - User Guide",
      "equipmentId": "EQ002",
      "equipmentName": "HVAC System Pro Series 500",
      "manufacturer": "Climate Solutions Corp",
      "version": "v3.0",
      "language": "English",
      "fileType": "PDF",
      "fileSize": "8.7 MB",
      "pages": 156,
      "category": "User Guide",
      "lastUpdated": "2024-04-20",
      "downloadCount": 32,
      "tags": ["Operation", "Configuration", "Safety", "Energy Efficiency"],
      "description": "Comprehensive user guide covering system operation, configuration settings, and energy efficiency optimization.",
      "thumbnail": "https://picsum.photos/100/140?random=2&keyword=guide",
      "isDownloaded": false,
      "isFavorite": true
    },
    {
      "id": "MAN003",
      "title": "Fire Safety System v3.1 - Installation Manual",
      "equipmentId": "EQ003",
      "equipmentName": "Fire Safety System v3.1",
      "manufacturer": "SafeTech Systems",
      "version": "v1.5",
      "language": "English",
      "fileType": "PDF",
      "fileSize": "12.3 MB",
      "pages": 89,
      "category": "Installation Manual",
      "lastUpdated": "2024-06-01",
      "downloadCount": 18,
      "tags": ["Installation", "Wiring", "Testing", "Compliance"],
      "description": "Step-by-step installation guide with wiring diagrams, testing procedures, and compliance requirements.",
      "thumbnail": "https://picsum.photos/100/140?random=3&keyword=installation",
      "isDownloaded": true,
      "isFavorite": true
    },
    {
      "id": "MAN004", 
      "title": "Conveyor Belt System MK4 - Parts Catalog",
      "equipmentId": "EQ004",
      "equipmentName": "Conveyor Belt System MK4",
      "manufacturer": "Industrial Motion Ltd",
      "version": "v2.3",
      "language": "English",
      "fileType": "PDF",
      "fileSize": "22.1 MB",
      "pages": 312,
      "category": "Parts Catalog",
      "lastUpdated": "2024-03-10",
      "downloadCount": 67,
      "tags": ["Parts", "Ordering", "Specifications", "Replacement"],
      "description": "Complete parts catalog with detailed specifications, part numbers, and ordering information for all system components.",
      "thumbnail": "https://picsum.photos/100/140?random=4&keyword=catalog",
      "isDownloaded": false,
      "isFavorite": false
    },
    {
      "id": "MAN005",
      "title": "Security Camera Network HD - Technical Manual",
      "equipmentId": "EQ005",
      "equipmentName": "Security Camera Network HD",
      "manufacturer": "SecureVision Technologies",
      "version": "v4.2",
      "language": "English",
      "fileType": "PDF",
      "fileSize": "18.9 MB",
      "pages": 201,
      "category": "Technical Manual",
      "lastUpdated": "2024-05-30",
      "downloadCount": 29,
      "tags": ["Configuration", "Network", "Recording", "Analytics"],
      "description": "Technical manual covering network configuration, recording settings, and advanced analytics features.",
      "thumbnail": "https://picsum.photos/100/140?random=5&keyword=technical",
      "isDownloaded": true,
      "isFavorite": false
    },
    {
      "id": "MAN006",
      "title": "General Safety Procedures Handbook",
      "equipmentId": "ALL",
      "equipmentName": "All Equipment",
      "manufacturer": "Safety First Corp",
      "version": "v1.8",
      "language": "English",
      "fileType": "PDF", 
      "fileSize": "6.4 MB",
      "pages": 94,
      "category": "Safety Manual",
      "lastUpdated": "2024-02-28",
      "downloadCount": 156,
      "tags": ["Safety", "Procedures", "PPE", "Emergency"],
      "description": "Essential safety procedures and protocols for all equipment operations, including emergency procedures and PPE requirements.",
      "thumbnail": "https://picsum.photos/100/140?random=6&keyword=safety",
      "isDownloaded": true,
      "isFavorite": true
    }
  ];

  List<Map<String, dynamic>> filteredManuals = [];
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedLanguage = "All";
  bool showFavoritesOnly = false;
  bool showDownloadedOnly = false;

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Service Manual", "value": "Service Manual"},
    {"label": "User Guide", "value": "User Guide"},
    {"label": "Installation Manual", "value": "Installation Manual"},
    {"label": "Parts Catalog", "value": "Parts Catalog"},
    {"label": "Technical Manual", "value": "Technical Manual"},
    {"label": "Safety Manual", "value": "Safety Manual"},
  ];

  List<Map<String, dynamic>> languageItems = [
    {"label": "All", "value": "All"},
    {"label": "English", "value": "English"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
  ];

  @override
  void initState() {
    super.initState();
    filteredManuals = manuals;
  }

  void _filterManuals() {
    filteredManuals = manuals.where((manual) {
      bool matchesSearch = manual["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          manual["equipmentName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          manual["manufacturer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          (manual["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      bool matchesCategory = selectedCategory == "All" || manual["category"] == selectedCategory;
      bool matchesLanguage = selectedLanguage == "All" || manual["language"] == selectedLanguage;
      bool matchesFavorites = !showFavoritesOnly || manual["isFavorite"] == true;
      bool matchesDownloaded = !showDownloadedOnly || manual["isDownloaded"] == true;
      
      return matchesSearch && matchesCategory && matchesLanguage && matchesFavorites && matchesDownloaded;
    }).toList();
    setState(() {});
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Service Manual":
        return primaryColor;
      case "User Guide":
        return infoColor;
      case "Installation Manual":
        return warningColor;
      case "Parts Catalog":
        return successColor;
      case "Technical Manual":
        return secondaryColor;
      case "Safety Manual":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildManualCard(Map<String, dynamic> manual) {
    bool isFavorite = manual["isFavorite"] as bool;
    bool isDownloaded = manual["isDownloaded"] as bool;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getCategoryColor(manual["category"]),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${manual["thumbnail"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                if (isDownloaded)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.download_done,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
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
                        "${manual["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        manual["isFavorite"] = !isFavorite;
                        setState(() {});
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 20,
                        color: isFavorite ? dangerColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(manual["category"]).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${manual["category"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: _getCategoryColor(manual["category"]),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${manual["manufacturer"]} • v${manual["version"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.picture_as_pdf,
                      size: 14,
                      color: dangerColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${manual["fileSize"]} • ${manual["pages"]} pages",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.download,
                      size: 14,
                      color: infoColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${manual["downloadCount"]} downloads",
                      style: TextStyle(
                        fontSize: 10,
                        color: infoColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Updated: ${manual["lastUpdated"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${manual["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: (manual["tags"] as List).take(3).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 9,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
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
                        label: isDownloaded ? "Open" : "Download",
                        size: bs.sm,
                        onPressed: () {
                          if (isDownloaded) {
                            // Open manual
                          } else {
                            // Download manual
                            manual["isDownloaded"] = true;
                            manual["downloadCount"] = (manual["downloadCount"] as int) + 1;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Preview",
                        size: bs.sm,
                        onPressed: () {
                          // Preview manual
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
    );
  }

  Widget _buildStatsCards() {
    int totalManuals = manuals.length;
    int downloadedManuals = manuals.where((m) => m["isDownloaded"] == true).length;
    int favoriteManuals = manuals.where((m) => m["isFavorite"] == true).length;
    double totalSize = manuals.fold(0.0, (sum, m) {
      String sizeStr = m["fileSize"].toString().replaceAll(" MB", "");
      return sum + (double.tryParse(sizeStr) ?? 0.0);
    });

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Total Manuals", "$totalManuals", Icons.library_books, primaryColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Downloaded", "$downloadedManuals", Icons.download_done, successColor),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Favorites", "$favoriteManuals", Icons.favorite, dangerColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Total Size", "${totalSize.toStringAsFixed(1)} MB", Icons.storage, infoColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Equipment Manuals"),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () {
              // Upload new manual
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Advanced search
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCards(),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Manuals",
                    value: searchQuery,
                    hint: "Search by title, equipment, or tags...",
                    onChanged: (value) {
                      searchQuery = value;
                      _filterManuals();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      _filterManuals();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Language",
                    items: languageItems,
                    value: selectedLanguage,
                    onChanged: (value, label) {
                      selectedLanguage = value;
                      _filterManuals();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Favorites Only",
                        "value": true,
                        "checked": showFavoritesOnly,
                      }
                    ],
                    value: [if (showFavoritesOnly) {"label": "Favorites Only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showFavoritesOnly = values.isNotEmpty;
                      _filterManuals();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Downloaded Only",
                        "value": true,
                        "checked": showDownloadedOnly,
                      }
                    ],
                    value: [if (showDownloadedOnly) {"label": "Downloaded Only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showDownloadedOnly = values.isNotEmpty;
                      _filterManuals();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "Equipment Manuals (${filteredManuals.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...filteredManuals.map((manual) => _buildManualCard(manual)).toList(),
          ],
        ),
      ),
    );
  }
}
