import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaSearchResultsView extends StatefulWidget {
  const NmaSearchResultsView({super.key});

  @override
  State<NmaSearchResultsView> createState() => _NmaSearchResultsViewState();
}

class _NmaSearchResultsViewState extends State<NmaSearchResultsView> {
  String searchQuery = "Flutter development";
  String selectedCategory = "all";
  String selectedSort = "relevance";
  bool isLoading = false;
  int currentPage = 1;
  int totalResults = 1247;

  List<Map<String, dynamic>> categoryTabs = [
    {"label": "All", "value": "all", "count": 1247},
    {"label": "Web", "value": "web", "count": 892},
    {"label": "Images", "value": "images", "count": 245},
    {"label": "Videos", "value": "videos", "count": 67},
    {"label": "News", "value": "news", "count": 34},
    {"label": "Shopping", "value": "shopping", "count": 9},
  ];

  List<Map<String, dynamic>> searchResults = [
    {
      "id": 1,
      "type": "web",
      "title": "Flutter - Build apps for any screen",
      "url": "https://flutter.dev",
      "description": "Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, desktop, and embedded devices from a single codebase.",
      "date": "2025-06-15",
      "domain": "flutter.dev",
      "snippet": "Flutter transforms the entire app development process. Build, test, and deploy beautiful mobile, web, desktop, and embedded apps from a single codebase.",
      "rating": 4.8,
      "favicon": "https://picsum.photos/32/32?random=1&keyword=flutter",
    },
    {
      "id": 2,
      "type": "web",
      "title": "Learn Flutter: Comprehensive Tutorial for Beginners",
      "url": "https://example.com/flutter-tutorial",
      "description": "Complete Flutter development course covering everything from basics to advanced concepts. Build real-world applications step by step.",
      "date": "2025-06-14",
      "domain": "example.com",
      "snippet": "Master Flutter development with our comprehensive tutorial series. Learn widgets, state management, navigation, and build amazing mobile apps.",
      "rating": 4.5,
      "favicon": "https://picsum.photos/32/32?random=2&keyword=tutorial",
    },
    {
      "id": 3,
      "type": "image",
      "title": "Flutter Architecture Diagram",
      "url": "https://example.com/flutter-architecture.png",
      "description": "Visual representation of Flutter's architecture and component structure",
      "imageUrl": "https://picsum.photos/300/200?random=3&keyword=architecture",
      "size": "1920x1080",
      "source": "Tech Blog",
      "date": "2025-06-13",
    },
    {
      "id": 4,
      "type": "video",
      "title": "Flutter in 100 Seconds",
      "url": "https://example.com/flutter-video",
      "description": "Quick overview of Flutter framework and its capabilities in under 2 minutes",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=video",
      "duration": "1:42",
      "channel": "Fireship",
      "views": "2.1M",
      "date": "2025-06-12",
    },
    {
      "id": 5,
      "type": "news",
      "title": "Google Announces Flutter 3.5 with Performance Improvements",
      "url": "https://news.example.com/flutter-3-5",
      "description": "Latest Flutter release brings significant performance enhancements and new features for cross-platform development.",
      "source": "Tech News Daily",
      "author": "Sarah Johnson",
      "date": "2025-06-10",
      "category": "Technology",
      "thumbnail": "https://picsum.photos/150/100?random=5&keyword=news",
    },
    {
      "id": 6,
      "type": "web",
      "title": "Flutter State Management: Provider vs Bloc vs Riverpod",
      "url": "https://blog.example.com/flutter-state-management",
      "description": "Comprehensive comparison of popular Flutter state management solutions with code examples and best practices.",
      "date": "2025-06-09",
      "domain": "blog.example.com",
      "snippet": "Choosing the right state management solution is crucial for Flutter apps. Compare Provider, Bloc, and Riverpod with practical examples.",
      "rating": 4.7,
      "favicon": "https://picsum.photos/32/32?random=6&keyword=blog",
    },
    {
      "id": 7,
      "type": "shopping",
      "title": "Flutter Complete Course Bundle",
      "url": "https://store.example.com/flutter-course",
      "description": "Comprehensive Flutter development course with 50+ hours of content and hands-on projects.",
      "price": 89.99,
      "originalPrice": 199.99,
      "rating": 4.6,
      "reviews": 1247,
      "store": "TechEd Store",
      "thumbnail": "https://picsum.photos/150/150?random=7&keyword=course",
    },
  ];

  List<Map<String, dynamic>> get filteredResults {
    if (selectedCategory == "all") {
      return searchResults;
    }
    return searchResults.where((result) => result["type"] == selectedCategory).toList();
  }

  Widget _buildSearchHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {
                  // Perform new search
                  _performSearch();
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "About ${totalResults.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} results",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: QHorizontalScroll(
        children: categoryTabs.map((category) {
          bool isSelected = selectedCategory == category["value"];
          return GestureDetector(
            onTap: () {
              selectedCategory = category["value"];
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${category["label"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : primaryColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? Colors.white.withAlpha(30)
                          : primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${category["count"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected 
                            ? Colors.white
                            : primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWebResult(Map<String, dynamic> result) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (result["favicon"] != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusXs),
                  child: Image.network(
                    "${result["favicon"]}",
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spSm),
              ],
              Expanded(
                child: Text(
                  "${result["domain"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                  ),
                ),
              ),
              if (result["rating"] != null) ...[
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${result["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${result["title"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${result["snippet"] ?? result["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "${result["url"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                ),
              ),
              Spacer(),
              Text(
                "${result["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageResult(Map<String, dynamic> result) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Image.network(
              "${result["imageUrl"]}",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${result["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${result["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "${result["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${result["source"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
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

  Widget _buildVideoResult(Map<String, dynamic> result) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${result["thumbnail"]}",
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${result["duration"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${result["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${result["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "${result["channel"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${result["views"]} views",
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
    );
  }

  Widget _buildNewsResult(Map<String, dynamic> result) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (result["thumbnail"] != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${result["thumbnail"]}",
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: spMd),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "NEWS",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${result["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${result["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${result["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "${result["source"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    if (result["author"] != null) ...[
                      Text(
                        " • ${result["author"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShoppingResult(Map<String, dynamic> result) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Image.network(
              "${result["thumbnail"]}",
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${result["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${result["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "\$${result["price"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    if (result["originalPrice"] != null) ...[
                      SizedBox(width: spSm),
                      Text(
                        "\$${result["originalPrice"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${result["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          " (${result["reviews"]})",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${result["store"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(Map<String, dynamic> result) {
    switch (result["type"]) {
      case "web":
        return _buildWebResult(result);
      case "image":
        return _buildImageResult(result);
      case "video":
        return _buildVideoResult(result);
      case "news":
        return _buildNewsResult(result);
      case "shopping":
        return _buildShoppingResult(result);
      default:
        return _buildWebResult(result);
    }
  }

  void _performSearch() {
    isLoading = true;
    setState(() {});
    
    // Simulate search delay
    Future.delayed(Duration(seconds: 1), () {
      isLoading = false;
      setState(() {});
      ss("Search completed");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results"),
        actions: [
          GestureDetector(
            onTap: () {
              // Show filters
            },
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.filter_list,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey.withAlpha(10),
            child: Column(
              children: [
                _buildSearchHeader(),
                _buildCategoryTabs(),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      _performSearch();
                    },
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          if (filteredResults.isEmpty)
                            Container(
                              padding: EdgeInsets.all(spXl),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: disabledColor,
                                  ),
                                  SizedBox(height: spMd),
                                  Text(
                                    "No results found",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "Try different keywords or filters",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Column(
                              children: filteredResults.map((result) => _buildResultItem(result)).toList(),
                            ),
                          
                          // Pagination
                          if (filteredResults.isNotEmpty) ...[
                            SizedBox(height: spMd),
                            Row(
                              children: [
                                QButton(
                                  label: "Previous",
                                  size: bs.sm,
                                  onPressed: currentPage > 1 ? () {
                                    currentPage--;
                                    setState(() {});
                                  } : null,
                                ),
                                Spacer(),
                                Text(
                                  "Page $currentPage",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                QButton(
                                  label: "Next",
                                  size: bs.sm,
                                  onPressed: () {
                                    currentPage++;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
