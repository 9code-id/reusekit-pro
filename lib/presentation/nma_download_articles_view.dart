import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaDownloadArticlesView extends StatefulWidget {
  const NmaDownloadArticlesView({super.key});

  @override
  State<NmaDownloadArticlesView> createState() => _NmaDownloadArticlesViewState();
}

class _NmaDownloadArticlesViewState extends State<NmaDownloadArticlesView> {
  String searchQuery = "";
  String selectedCategory = "All";
  List<String> selectedArticles = [];
  bool isSelectMode = false;

  List<Map<String, dynamic>> availableArticles = [
    {
      "id": "1",
      "title": "Future of Smart Agriculture",
      "category": "Technology",
      "author": "Dr. Jennifer Park",
      "readTime": "14 min",
      "publishDate": "2024-12-16",
      "isDownloaded": false,
      "image": "https://picsum.photos/300/200?random=11&keyword=smart-farming",
      "description": "Exploring AI and IoT applications in modern farming practices.",
      "size": "3.2 MB",
      "tags": ["AI", "IoT", "Smart Farming"],
      "rating": 4.8,
      "downloads": 15420
    },
    {
      "id": "2",
      "title": "Vertical Farming Revolution",
      "category": "Innovation",
      "author": "Prof. Alex Chen",
      "readTime": "10 min",
      "publishDate": "2024-12-15",
      "isDownloaded": true,
      "image": "https://picsum.photos/300/200?random=12&keyword=vertical-farming",
      "description": "How vertical farming is changing urban agriculture landscapes.",
      "size": "2.1 MB",
      "tags": ["Vertical", "Urban", "Innovation"],
      "rating": 4.6,
      "downloads": 12850
    },
    {
      "id": "3",
      "title": "Drought-Resistant Crop Varieties",
      "category": "Research",
      "author": "Dr. Maria Santos",
      "readTime": "12 min",
      "publishDate": "2024-12-14",
      "isDownloaded": false,
      "image": "https://picsum.photos/300/200?random=13&keyword=drought-crops",
      "description": "Latest research on developing crops that can withstand water scarcity.",
      "size": "2.8 MB",
      "tags": ["Drought", "Research", "Crops"],
      "rating": 4.9,
      "downloads": 18760
    },
    {
      "id": "4",
      "title": "Precision Agriculture Techniques",
      "category": "Technology",
      "author": "Dr. Robert Kim",
      "readTime": "16 min",
      "publishDate": "2024-12-13",
      "isDownloaded": false,
      "image": "https://picsum.photos/300/200?random=14&keyword=precision-agriculture",
      "description": "Using GPS and sensors for precise field management and optimization.",
      "size": "3.5 MB",
      "tags": ["Precision", "GPS", "Sensors"],
      "rating": 4.7,
      "downloads": 14230
    },
    {
      "id": "5",
      "title": "Organic Pest Control Methods",
      "category": "Organic",
      "author": "Dr. Emily Johnson",
      "readTime": "9 min",
      "publishDate": "2024-12-12",
      "isDownloaded": true,
      "image": "https://picsum.photos/300/200?random=15&keyword=organic-pest",
      "description": "Natural and sustainable approaches to pest management in agriculture.",
      "size": "1.9 MB",
      "tags": ["Organic", "Pest Control", "Natural"],
      "rating": 4.5,
      "downloads": 11640
    },
    {
      "id": "6",
      "title": "Greenhouse Automation Systems",
      "category": "Technology",
      "author": "Prof. David Wilson",
      "readTime": "13 min",
      "publishDate": "2024-12-11",
      "isDownloaded": false,
      "image": "https://picsum.photos/300/200?random=16&keyword=greenhouse-automation",
      "description": "Automated climate control and monitoring systems for greenhouse cultivation.",
      "size": "2.7 MB",
      "tags": ["Automation", "Greenhouse", "Climate"],
      "rating": 4.8,
      "downloads": 16890
    },
    {
      "id": "7",
      "title": "Soil Microbiome Analysis",
      "category": "Research",
      "author": "Dr. Sarah Lee",
      "readTime": "11 min",
      "publishDate": "2024-12-10",
      "isDownloaded": false,
      "image": "https://picsum.photos/300/200?random=17&keyword=soil-microbiome",
      "description": "Understanding soil microorganisms and their impact on plant health.",
      "size": "2.4 MB",
      "tags": ["Soil", "Microbiome", "Health"],
      "rating": 4.6,
      "downloads": 13570
    },
    {
      "id": "8",
      "title": "Renewable Energy in Agriculture",
      "category": "Energy",
      "author": "Dr. Michael Brown",
      "readTime": "15 min",
      "publishDate": "2024-12-09",
      "isDownloaded": false,
      "image": "https://picsum.photos/300/200?random=18&keyword=renewable-agriculture",
      "description": "Solar and wind energy applications in modern farming operations.",
      "size": "3.3 MB",
      "tags": ["Renewable", "Solar", "Wind"],
      "rating": 4.7,
      "downloads": 15240
    }
  ];

  List<String> categories = ["All", "Technology", "Innovation", "Research", "Organic", "Energy"];

  List<Map<String, dynamic>> get filteredArticles {
    List<Map<String, dynamic>> filtered = availableArticles;

    if (selectedCategory != "All") {
      filtered = filtered.where((article) => article["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((article) =>
          article["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          article["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          article["author"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  int get selectedCount => selectedArticles.length;
  
  double get totalSize {
    double total = 0;
    for (String id in selectedArticles) {
      final article = availableArticles.firstWhere((a) => a["id"] == id);
      final sizeString = article["size"] as String;
      final size = double.parse(sizeString.replaceAll(" MB", ""));
      total += size;
    }
    return total;
  }

  void toggleSelection(String articleId) {
    if (selectedArticles.contains(articleId)) {
      selectedArticles.remove(articleId);
    } else {
      selectedArticles.add(articleId);
    }
    setState(() {});
  }

  void selectAll() {
    selectedArticles = filteredArticles.where((a) => !(a["isDownloaded"] as bool)).map((a) => a["id"].toString()).toList();
    setState(() {});
  }

  void clearSelection() {
    selectedArticles.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectMode ? "Select Articles" : "Download Articles"),
        actions: [
          if (!isSelectMode)
            IconButton(
              icon: Icon(Icons.checklist),
              onPressed: () {
                isSelectMode = true;
                setState(() {});
              },
            ),
          if (isSelectMode) ...[
            IconButton(
              icon: Icon(Icons.select_all),
              onPressed: selectAll,
            ),
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: clearSelection,
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                isSelectMode = false;
                clearSelection();
              },
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              spacing: spSm,
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search articles...",
                        value: searchQuery,
                        hint: "Search by title, author, or content",
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

                // Category Filter
                QCategoryPicker(
                  items: categories.map((category) => {
                    "label": category,
                    "value": category,
                  }).toList(),
                  value: selectedCategory,
                  onChanged: (index, label, value, item) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Stats Row
          Container(
            padding: EdgeInsets.all(spSm),
            color: Colors.grey[50],
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${filteredArticles.where((a) => !(a["isDownloaded"] as bool)).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Available",
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
                        "${filteredArticles.where((a) => a["isDownloaded"] as bool).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                if (isSelectMode)
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "$selectedCount",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Selected",
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
          ),

          // Articles List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredArticles.length,
              itemBuilder: (context, index) {
                final article = filteredArticles[index];
                final isDownloaded = article["isDownloaded"] as bool;
                final isSelected = selectedArticles.contains(article["id"]);

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (isSelectMode && !isDownloaded) {
                        toggleSelection(article["id"]);
                      }
                    },
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Row(
                        children: [
                          // Article Image
                          Container(
                            width: 80,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusXs),
                              child: Stack(
                                children: [
                                  Image.network(
                                    "${article["image"]}",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  if (isDownloaded)
                                    Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.black45,
                                      child: Center(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: successColor,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  if (isSelectMode && !isDownloaded)
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: isSelected ? primaryColor : Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected ? primaryColor : disabledColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: isSelected
                                            ? Icon(
                                                Icons.check,
                                                size: 12,
                                                color: Colors.white,
                                              )
                                            : null,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: spSm),

                          // Article Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${article["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isDownloaded ? disabledBoldColor : primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${article["description"]}",
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
                                      Icons.person,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${article["author"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.schedule,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${article["readTime"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${article["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      " ${(article["rating"] as double).toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${article["size"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Action Button
                          if (!isSelectMode)
                            Column(
                              children: [
                                if (isDownloaded)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Downloaded",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                else
                                  QButton(
                                    icon: Icons.download,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Simulate download
                                      article["isDownloaded"] = true;
                                      setState(() {});
                                      ss("Article downloaded successfully!");
                                    },
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: isSelectMode && selectedCount > 0
          ? Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$selectedCount articles selected",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total size: ${totalSize.toStringAsFixed(1)} MB",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Download Selected",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: () {
                      // Simulate download
                      for (String id in selectedArticles) {
                        final article = availableArticles.firstWhere((a) => a["id"] == id);
                        article["isDownloaded"] = true;
                      }
                      clearSelection();
                      isSelectMode = false;
                      setState(() {});
                      ss("${selectedCount} articles downloaded successfully!");
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
