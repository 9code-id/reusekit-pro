import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaDocumentLibraryView extends StatefulWidget {
  const LcaDocumentLibraryView({super.key});

  @override
  State<LcaDocumentLibraryView> createState() => _LcaDocumentLibraryViewState();
}

class _LcaDocumentLibraryViewState extends State<LcaDocumentLibraryView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedTag = "All";
  bool showFavorites = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Templates", "value": "templates"},
    {"label": "Forms", "value": "forms"},
    {"label": "Precedents", "value": "precedents"},
    {"label": "Research", "value": "research"},
    {"label": "Resources", "value": "resources"},
  ];

  List<Map<String, dynamic>> tags = [
    {"label": "All", "value": "All"},
    {"label": "Civil", "value": "civil"},
    {"label": "Criminal", "value": "criminal"},
    {"label": "Corporate", "value": "corporate"},
    {"label": "Family", "value": "family"},
    {"label": "Real Estate", "value": "real-estate"},
  ];

  List<Map<String, dynamic>> libraryItems = [
    {
      "id": 1,
      "title": "Contract Template - Service Agreement",
      "description": "Standard service agreement template with customizable terms and conditions",
      "category": "templates",
      "tags": ["corporate", "contract", "service"],
      "type": "Template",
      "format": "DOCX",
      "size": "245 KB",
      "downloads": 1247,
      "rating": 4.8,
      "lastUpdated": "2024-01-15",
      "author": "Legal Templates Inc.",
      "favorite": true,
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=document",
    },
    {
      "id": 2,
      "title": "Motion to Dismiss Template",
      "description": "Comprehensive motion to dismiss template with supporting case law references",
      "category": "templates",
      "tags": ["civil", "motion", "litigation"],
      "type": "Template",
      "format": "PDF",
      "size": "890 KB",
      "downloads": 892,
      "rating": 4.9,
      "lastUpdated": "2024-01-14",
      "author": "Civil Litigation Forms",
      "favorite": false,
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=legal",
    },
    {
      "id": 3,
      "title": "Discovery Request Forms",
      "description": "Complete set of discovery forms including interrogatories and document requests",
      "category": "forms",
      "tags": ["civil", "discovery", "litigation"],
      "type": "Form Set",
      "format": "PDF",
      "size": "1.2 MB",
      "downloads": 654,
      "rating": 4.7,
      "lastUpdated": "2024-01-13",
      "author": "Discovery Pro",
      "favorite": true,
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=forms",
    },
    {
      "id": 4,
      "title": "Family Law Precedent Cases",
      "description": "Collection of landmark family law cases with analysis and applications",
      "category": "precedents",
      "tags": ["family", "precedent", "case law"],
      "type": "Case Collection",
      "format": "PDF",
      "size": "15.7 MB",
      "downloads": 423,
      "rating": 4.6,
      "lastUpdated": "2024-01-12",
      "author": "Family Law Research",
      "favorite": false,
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=law",
    },
    {
      "id": 5,
      "title": "Real Estate Purchase Agreement",
      "description": "Comprehensive real estate purchase agreement with state-specific clauses",
      "category": "templates",
      "tags": ["real-estate", "contract", "purchase"],
      "type": "Template",
      "format": "DOCX",
      "size": "567 KB",
      "downloads": 1156,
      "rating": 4.8,
      "lastUpdated": "2024-01-11",
      "author": "Real Estate Legal",
      "favorite": true,
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=realestate",
    },
    {
      "id": 6,
      "title": "Criminal Defense Research Guide",
      "description": "Comprehensive guide to criminal defense strategies and case preparation",
      "category": "research",
      "tags": ["criminal", "defense", "strategy"],
      "type": "Guide",
      "format": "PDF",
      "size": "8.9 MB",
      "downloads": 287,
      "rating": 4.5,
      "lastUpdated": "2024-01-10",
      "author": "Criminal Defense Association",
      "favorite": false,
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=criminal",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return libraryItems.where((item) {
      bool matchesSearch = item["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesTag = selectedTag == "All" || (item["tags"] as List).contains(selectedTag);
      bool matchesFavorites = !showFavorites || item["favorite"] == true;
      
      return matchesSearch && matchesCategory && matchesTag && matchesFavorites;
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "templates":
        return primaryColor;
      case "forms":
        return successColor;
      case "precedents":
        return infoColor;
      case "research":
        return warningColor;
      case "resources":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document Library"),
        actions: [
          IconButton(
            icon: Icon(showFavorites ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              showFavorites = !showFavorites;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () {
              // Navigate to upload
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            QTextField(
              label: "Search library",
              value: searchQuery,
              hint: "Search templates, forms, precedents...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories,
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
                    label: "Practice Area",
                    items: tags,
                    value: selectedTag,
                    onChanged: (value, label) {
                      selectedTag = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.library_books, color: primaryColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${libraryItems.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Items",
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
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.favorite, color: dangerColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${libraryItems.where((item) => item["favorite"] == true).length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Favorites",
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
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.download, color: successColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${(libraryItems.fold(0, (sum, item) => sum + (item["downloads"] as int)) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: 24,
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
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Featured Items
            Row(
              children: [
                Text(
                  "Featured Items",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),

            QHorizontalScroll(
              children: libraryItems.take(3).map((item) {
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(right: spSm),
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
                          "${item["thumbnail"]}",
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor("${item["category"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getCategoryColor("${item["category"]}"),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                if (item["favorite"] == true)
                                  Icon(Icons.favorite, color: dangerColor, size: 16),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${item["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${item["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(Icons.download, color: disabledBoldColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "${(item["downloads"] as int) > 1000 ? '${((item["downloads"] as int) / 1000).toStringAsFixed(1)}K' : item["downloads"]}",
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
              }).toList(),
            ),
            SizedBox(height: spLg),

            // All Items
            Row(
              children: [
                Text(
                  "All Items (${filteredItems.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (showFavorites)
                  Container(
                    margin: EdgeInsets.only(left: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "FAVORITES ONLY",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredItems.map((item) {
                return Container(
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
                          "${item["thumbnail"]}",
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor("${item["category"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getCategoryColor("${item["category"]}"),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    item["favorite"] = !item["favorite"];
                                    setState(() {});
                                  },
                                  child: Icon(
                                    item["favorite"] == true ? Icons.favorite : Icons.favorite_border,
                                    color: dangerColor,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${item["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${item["description"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text(
                                  "${item["format"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  " • ${item["size"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 12),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["rating"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${(item["downloads"] as int) > 1000 ? '${((item["downloads"] as int) / 1000).toStringAsFixed(1)}K' : item["downloads"]} downloads",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
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
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
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
