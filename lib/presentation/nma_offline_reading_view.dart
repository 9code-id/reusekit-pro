import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaOfflineReadingView extends StatefulWidget {
  const NmaOfflineReadingView({super.key});

  @override
  State<NmaOfflineReadingView> createState() => _NmaOfflineReadingViewState();
}

class _NmaOfflineReadingViewState extends State<NmaOfflineReadingView> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool isGridView = false;

  List<Map<String, dynamic>> offlineArticles = [
    {
      "id": "1",
      "title": "Climate Change Impact on Agriculture",
      "category": "Environment",
      "author": "Dr. Sarah Wilson",
      "readTime": "12 min",
      "downloadDate": "2024-12-15",
      "isRead": false,
      "image": "https://picsum.photos/300/200?random=1&keyword=agriculture",
      "description": "Understanding how climate change affects crop yields and farming practices worldwide.",
      "size": "2.3 MB",
      "tags": ["Climate", "Farming", "Environment"]
    },
    {
      "id": "2",
      "title": "Sustainable Farming Techniques",
      "category": "Agriculture",
      "author": "Prof. Michael Chen",
      "readTime": "8 min",
      "downloadDate": "2024-12-14",
      "isRead": true,
      "image": "https://picsum.photos/300/200?random=2&keyword=farming",
      "description": "Modern sustainable farming methods that increase productivity while protecting the environment.",
      "size": "1.8 MB",
      "tags": ["Sustainable", "Techniques", "Productivity"]
    },
    {
      "id": "3",
      "title": "Biotechnology in Modern Agriculture",
      "category": "Technology",
      "author": "Dr. Emma Rodriguez",
      "readTime": "15 min",
      "downloadDate": "2024-12-13",
      "isRead": false,
      "image": "https://picsum.photos/300/200?random=3&keyword=biotechnology",
      "description": "The role of biotechnology in improving crop resistance and nutritional value.",
      "size": "3.1 MB",
      "tags": ["Biotech", "Innovation", "Crops"]
    },
    {
      "id": "4",
      "title": "Water Management Systems",
      "category": "Water",
      "author": "Dr. James Anderson",
      "readTime": "10 min",
      "downloadDate": "2024-12-12",
      "isRead": true,
      "image": "https://picsum.photos/300/200?random=4&keyword=irrigation",
      "description": "Efficient water management strategies for agricultural sustainability.",
      "size": "2.5 MB",
      "tags": ["Water", "Irrigation", "Efficiency"]
    },
    {
      "id": "5",
      "title": "Soil Health and Nutrition",
      "category": "Soil Science",
      "author": "Dr. Lisa Thompson",
      "readTime": "11 min",
      "downloadDate": "2024-12-11",
      "isRead": false,
      "image": "https://picsum.photos/300/200?random=5&keyword=soil",
      "description": "Understanding soil composition and nutrient management for optimal crop growth.",
      "size": "2.0 MB",
      "tags": ["Soil", "Nutrition", "Health"]
    },
    {
      "id": "6",
      "title": "Organic Farming Principles",
      "category": "Organic",
      "author": "Prof. David Kumar",
      "readTime": "9 min",
      "downloadDate": "2024-12-10",
      "isRead": true,
      "image": "https://picsum.photos/300/200?random=6&keyword=organic",
      "description": "Core principles and practices of organic farming methods.",
      "size": "1.7 MB",
      "tags": ["Organic", "Natural", "Principles"]
    }
  ];

  List<String> categories = ["All", "Environment", "Agriculture", "Technology", "Water", "Soil Science", "Organic"];

  List<Map<String, dynamic>> get filteredArticles {
    List<Map<String, dynamic>> filtered = offlineArticles;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Reading"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              //navigateTo('NmaDownloadArticlesView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
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

            // Storage Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.storage,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Storage Used: 12.4 MB of 50 MB",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${offlineArticles.length} articles downloaded",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "75%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
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

            // Stats Row
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
                        Text(
                          "${offlineArticles.where((a) => !(a["isRead"] as bool)).length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Unread",
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
                        Text(
                          "${offlineArticles.where((a) => a["isRead"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Read",
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
                        Text(
                          "${categories.length - 1}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Categories",
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

            // Articles List/Grid
            if (isGridView)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredArticles.map((article) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Article Image
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  "${article["image"]}",
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                                if (article["isRead"] as bool)
                                  Positioned(
                                    top: spXs,
                                    right: spXs,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "Read",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                Positioned(
                                  bottom: spXs,
                                  left: spXs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${article["readTime"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Article Info
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${article["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                                  Expanded(
                                    child: Text(
                                      "${article["author"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Text(
                                    "${article["size"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Read Article",
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateTo('ArticleReaderView')
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            else
              Column(
                spacing: spSm,
                children: filteredArticles.map((article) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        // Article Image
                        Container(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              bottomLeft: Radius.circular(radiusSm),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  "${article["image"]}",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                if (article["isRead"] as bool)
                                  Positioned(
                                    top: spXs,
                                    right: spXs,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        // Article Info
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${article["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      "${article["readTime"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
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
                                    Text(
                                      "${article["author"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${article["size"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  child: QButton(
                                    label: "Read Article",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('ArticleReaderView')
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

            if (filteredArticles.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.article,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Articles Found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      searchQuery.isNotEmpty
                          ? "No articles match your search criteria"
                          : "No articles downloaded for this category",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Download Articles",
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('NmaDownloadArticlesView')
                      },
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
