import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaComparisonView extends StatefulWidget {
  const PpaComparisonView({super.key});

  @override
  State<PpaComparisonView> createState() => _PpaComparisonViewState();
}

class _PpaComparisonViewState extends State<PpaComparisonView> {
  int selectedComparison = 0;
  String sortBy = "recent";
  String filterBy = "all";
  bool showMetadata = true;

  final List<Map<String, dynamic>> comparisons = [
    {
      "id": "comp_1",
      "title": "Portrait Enhancement",
      "beforeImage": "https://picsum.photos/400/600?random=1",
      "afterImage": "https://picsum.photos/400/600?random=2",
      "category": "portrait",
      "date": DateTime.now().subtract(Duration(hours: 2)),
      "views": 45,
      "likes": 12,
      "shared": 3,
      "tags": ["beauty", "enhancement", "skin"],
      "metadata": {
        "brightness": "+15%",
        "contrast": "+8%",
        "saturation": "+5%",
        "filter": "Natural"
      }
    },
    {
      "id": "comp_2",
      "title": "Landscape Correction",
      "beforeImage": "https://picsum.photos/600/400?random=3",
      "afterImage": "https://picsum.photos/600/400?random=4",
      "category": "landscape",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "views": 128,
      "likes": 34,
      "shared": 8,
      "tags": ["nature", "color", "correction"],
      "metadata": {
        "highlights": "-12%",
        "shadows": "+18%",
        "vibrance": "+25%",
        "filter": "Vivid"
      }
    },
    {
      "id": "comp_3",
      "title": "Product Photo",
      "beforeImage": "https://picsum.photos/500/500?random=5",
      "afterImage": "https://picsum.photos/500/500?random=6",
      "category": "product",
      "date": DateTime.now().subtract(Duration(days: 2)),
      "views": 89,
      "likes": 23,
      "shared": 5,
      "tags": ["product", "commercial", "clean"],
      "metadata": {
        "background": "Removed",
        "exposure": "+5%",
        "sharpness": "+10%",
        "filter": "Clean"
      }
    },
    {
      "id": "comp_4",
      "title": "Street Photography",
      "beforeImage": "https://picsum.photos/600/400?random=7",
      "afterImage": "https://picsum.photos/600/400?random=8",
      "category": "street",
      "date": DateTime.now().subtract(Duration(days: 3)),
      "views": 67,
      "likes": 18,
      "shared": 4,
      "tags": ["urban", "black&white", "dramatic"],
      "metadata": {
        "style": "B&W Conversion",
        "contrast": "+20%",
        "grain": "+8%",
        "filter": "Dramatic"
      }
    },
    {
      "id": "comp_5",
      "title": "Food Photography",
      "beforeImage": "https://picsum.photos/500/600?random=9",
      "afterImage": "https://picsum.photos/500/600?random=10",
      "category": "food",
      "date": DateTime.now().subtract(Duration(days: 5)),
      "views": 156,
      "likes": 42,
      "shared": 12,
      "tags": ["food", "appetizing", "warm"],
      "metadata": {
        "warmth": "+15%",
        "saturation": "+12%",
        "clarity": "+8%",
        "filter": "Food"
      }
    },
  ];

  final List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Recent", "value": "recent"},
    {"label": "Most Popular", "value": "popular"},
    {"label": "Most Liked", "value": "likes"},
    {"label": "Most Shared", "value": "shared"},
    {"label": "Alphabetical", "value": "name"},
  ];

  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Portrait", "value": "portrait"},
    {"label": "Landscape", "value": "landscape"},
    {"label": "Product", "value": "product"},
    {"label": "Street", "value": "street"},
    {"label": "Food", "value": "food"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Comparisons"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _createNewComparison();
            },
          ),
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {
              _searchComparisons();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter and Sort Bar
          Container(
            padding: EdgeInsets.all(spSm),
            color: Colors.grey[50],
            child: Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter",
                    items: filterOptions,
                    value: filterBy,
                    onChanged: (value, label) {
                      filterBy = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Sort",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
                QButton(
                  icon: showMetadata ? Icons.info : Icons.info_outline,
                  size: bs.sm,
                  onPressed: () {
                    showMetadata = !showMetadata;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Row(
              children: [
                // Comparison List
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      right: BorderSide(color: disabledOutlineBorderColor),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.all(spXs),
                    itemCount: _getFilteredComparisons().length,
                    itemBuilder: (context, index) {
                      final comparison = _getFilteredComparisons()[index];
                      final isSelected = selectedComparison == index;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: GestureDetector(
                          onTap: () {
                            selectedComparison = index;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(32) : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(
                                color: isSelected ? primaryColor : Colors.transparent,
                              ),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    image: DecorationImage(
                                      image: NetworkImage("${comparison["beforeImage"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${comparison["title"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  spacing: 4,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      size: 10,
                                      color: disabledColor,
                                    ),
                                    Text(
                                      "${comparison["likes"]}",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: disabledColor,
                                      ),
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

                // Main Comparison View
                Expanded(
                  child: _buildMainComparisonView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainComparisonView() {
    if (_getFilteredComparisons().isEmpty) {
      return Center(
        child: Column(
          spacing: spSm,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.compare,
              size: 64,
              color: disabledColor,
            ),
            Text(
              "No comparisons found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your filters or create a new comparison",
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Create Comparison",
              size: bs.md,
              onPressed: () {
                _createNewComparison();
              },
            ),
          ],
        ),
      );
    }

    final comparison = _getFilteredComparisons()[selectedComparison];
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${comparison["title"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      spacing: spSm,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        Text(
                          "${(comparison["date"] as DateTime).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(32),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${comparison["category"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {
                  _shareComparison(comparison);
                },
              ),
              QButton(
                icon: Icons.favorite_border,
                size: bs.sm,
                onPressed: () {
                  _likeComparison(comparison);
                },
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showComparisonOptions(comparison);
                },
              ),
            ],
          ),

          // Before/After Images
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Column(
                  spacing: spSm,
                  children: [
                    Text(
                      "BEFORE",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                        image: DecorationImage(
                          image: NetworkImage("${comparison["beforeImage"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: spSm,
                  children: [
                    Text(
                      "AFTER",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                        image: DecorationImage(
                          image: NetworkImage("${comparison["afterImage"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Stats
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Row(
              spacing: spLg,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(Icons.visibility, "Views", "${comparison["views"]}"),
                _buildStatItem(Icons.favorite, "Likes", "${comparison["likes"]}"),
                _buildStatItem(Icons.share, "Shares", "${comparison["shared"]}"),
              ],
            ),
          ),

          // Tags
          Text(
            "Tags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (comparison["tags"] as List<String>).map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(32),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "#$tag",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              );
            }).toList(),
          ),

          // Metadata (if enabled)
          if (showMetadata) ...[
            Text(
              "Edit Metadata",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spXs,
                children: (comparison["metadata"] as Map<String, dynamic>).entries.map((entry) {
                  return Row(
                    children: [
                      Text(
                        "${entry.key}:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${entry.value}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.md,
                  onPressed: () {
                    _editComparison(comparison);
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Duplicate",
                  size: bs.md,
                  onPressed: () {
                    _duplicateComparison(comparison);
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Export",
                  size: bs.md,
                  onPressed: () {
                    _exportComparison(comparison);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      spacing: spXs,
      children: [
        Icon(
          icon,
          size: 20,
          color: primaryColor,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getFilteredComparisons() {
    List<Map<String, dynamic>> filtered = comparisons;

    // Apply filter
    if (filterBy != "all") {
      filtered = filtered.where((comp) => comp["category"] == filterBy).toList();
    }

    // Apply sort
    switch (sortBy) {
      case "recent":
        filtered.sort((a, b) => (b["date"] as DateTime).compareTo(a["date"] as DateTime));
        break;
      case "popular":
        filtered.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
        break;
      case "likes":
        filtered.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case "shared":
        filtered.sort((a, b) => (b["shared"] as int).compareTo(a["shared"] as int));
        break;
      case "name":
        filtered.sort((a, b) => (a["title"] as String).compareTo(b["title"] as String));
        break;
    }

    return filtered;
  }

  void _createNewComparison() {
    ss("Creating new comparison");
  }

  void _searchComparisons() {
    ss("Search comparisons");
  }

  void _shareComparison(Map<String, dynamic> comparison) {
    ss("Sharing ${comparison["title"]}");
  }

  void _likeComparison(Map<String, dynamic> comparison) {
    ss("Liked ${comparison["title"]}");
  }

  void _showComparisonOptions(Map<String, dynamic> comparison) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Comparison Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Comparison"),
              onTap: () {
                back();
                _editComparison(comparison);
              },
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text("Duplicate"),
              onTap: () {
                back();
                _duplicateComparison(comparison);
              },
            ),
            ListTile(
              leading: Icon(Icons.download),
              title: Text("Export"),
              onTap: () {
                back();
                _exportComparison(comparison);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete", style: TextStyle(color: dangerColor)),
              onTap: () {
                back();
                _deleteComparison(comparison);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editComparison(Map<String, dynamic> comparison) {
    ss("Editing ${comparison["title"]}");
  }

  void _duplicateComparison(Map<String, dynamic> comparison) {
    ss("Duplicated ${comparison["title"]}");
  }

  void _exportComparison(Map<String, dynamic> comparison) {
    ss("Exporting ${comparison["title"]}");
  }

  void _deleteComparison(Map<String, dynamic> comparison) async {
    bool isConfirmed = await confirm("Delete ${comparison["title"]}?");
    if (isConfirmed) {
      ss("Deleted ${comparison["title"]}");
    }
  }
}
