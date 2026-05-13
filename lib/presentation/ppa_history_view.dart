import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaHistoryView extends StatefulWidget {
  const PpaHistoryView({super.key});

  @override
  State<PpaHistoryView> createState() => _PpaHistoryViewState();
}

class _PpaHistoryViewState extends State<PpaHistoryView> {
  String viewMode = "timeline";
  String filterBy = "all";
  String sortBy = "recent";
  bool showDetails = true;
  
  final List<Map<String, dynamic>> historyItems = [
    {
      "id": "history_1",
      "title": "Portrait Enhancement Session",
      "description": "Enhanced a portrait photo with beauty filters",
      "type": "edit_session",
      "date": DateTime.now().subtract(Duration(hours: 2)),
      "duration": "15 min",
      "image": "https://picsum.photos/400/600?random=1",
      "finalImage": "https://picsum.photos/400/600?random=2",
      "actions": [
        {"action": "brightness", "value": "+12%"},
        {"action": "skin_smooth", "value": "medium"},
        {"action": "eye_enhance", "value": "subtle"},
        {"action": "teeth_whiten", "value": "light"},
      ],
      "tags": ["portrait", "beauty", "enhancement"],
      "favorite": true,
    },
    {
      "id": "history_2",
      "title": "Landscape Color Grading",
      "description": "Applied cinematic color grading to landscape",
      "type": "edit_session",
      "date": DateTime.now().subtract(Duration(hours: 6)),
      "duration": "22 min",
      "image": "https://picsum.photos/600/400?random=3",
      "finalImage": "https://picsum.photos/600/400?random=4",
      "actions": [
        {"action": "color_grade", "value": "cinematic"},
        {"action": "highlights", "value": "-15%"},
        {"action": "shadows", "value": "+20%"},
        {"action": "vibrance", "value": "+18%"},
      ],
      "tags": ["landscape", "cinematic", "color"],
      "favorite": false,
    },
    {
      "id": "history_3",
      "title": "Product Photo Cleanup",
      "description": "Cleaned up product photo for e-commerce",
      "type": "edit_session",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "duration": "8 min",
      "image": "https://picsum.photos/500/500?random=5",
      "finalImage": "https://picsum.photos/500/500?random=6",
      "actions": [
        {"action": "background_remove", "value": "auto"},
        {"action": "lighting", "value": "product"},
        {"action": "sharpness", "value": "+10%"},
      ],
      "tags": ["product", "e-commerce", "cleanup"],
      "favorite": false,
    },
    {
      "id": "history_4",
      "title": "Instagram Story Creation",
      "description": "Created story template with text overlay",
      "type": "creation",
      "date": DateTime.now().subtract(Duration(days: 2)),
      "duration": "12 min",
      "image": "https://picsum.photos/300/500?random=7",
      "finalImage": "https://picsum.photos/300/500?random=8",
      "actions": [
        {"action": "template", "value": "story_modern"},
        {"action": "text_overlay", "value": "added"},
        {"action": "animation", "value": "fade_in"},
      ],
      "tags": ["social", "story", "template"],
      "favorite": true,
    },
    {
      "id": "history_5",
      "title": "Batch Photo Processing",
      "description": "Processed 25 photos with batch actions",
      "type": "batch",
      "date": DateTime.now().subtract(Duration(days: 3)),
      "duration": "45 min",
      "image": "https://picsum.photos/400/400?random=9",
      "finalImage": "https://picsum.photos/400/400?random=10",
      "actions": [
        {"action": "resize", "value": "1080x1080"},
        {"action": "watermark", "value": "bottom_right"},
        {"action": "export", "value": "JPG_high"},
      ],
      "tags": ["batch", "resize", "watermark"],
      "favorite": false,
    },
    {
      "id": "history_6",
      "title": "Photo Restoration",
      "description": "Restored old family photo",
      "type": "restoration",
      "date": DateTime.now().subtract(Duration(days: 5)),
      "duration": "35 min",
      "image": "https://picsum.photos/400/500?random=11",
      "finalImage": "https://picsum.photos/400/500?random=12",
      "actions": [
        {"action": "scratch_removal", "value": "ai_auto"},
        {"action": "color_restore", "value": "vintage"},
        {"action": "noise_reduction", "value": "medium"},
      ],
      "tags": ["restoration", "vintage", "family"],
      "favorite": true,
    },
  ];

  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All Activities", "value": "all"},
    {"label": "Edit Sessions", "value": "edit_session"},
    {"label": "Creations", "value": "creation"},
    {"label": "Batch Processing", "value": "batch"},
    {"label": "Restorations", "value": "restoration"},
    {"label": "Favorites Only", "value": "favorites"},
  ];

  final List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Recent", "value": "recent"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Duration (Longest)", "value": "duration_long"},
    {"label": "Duration (Shortest)", "value": "duration_short"},
    {"label": "Alphabetical", "value": "alphabetical"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit History"),
        actions: [
          QButton(
            icon: viewMode == "timeline" ? Icons.view_list : Icons.timeline,
            size: bs.sm,
            onPressed: () {
              viewMode = viewMode == "timeline" ? "list" : "timeline";
              setState(() {});
            },
          ),
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {
              _searchHistory();
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
                  icon: showDetails ? Icons.info : Icons.info_outline,
                  size: bs.sm,
                  onPressed: () {
                    showDetails = !showDetails;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Statistics Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              spacing: spLg,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem("Total Sessions", "${_getFilteredHistory().length}"),
                _buildStatItem("This Week", "${_getThisWeekCount()}"),
                _buildStatItem("Favorites", "${_getFavoritesCount()}"),
                _buildStatItem("Total Time", "${_getTotalTime()}"),
              ],
            ),
          ),

          // History Content
          Expanded(
            child: viewMode == "timeline" ? _buildTimelineView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      spacing: spXs,
      children: [
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
            fontSize: 10,
            color: disabledBoldColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTimelineView() {
    final filteredHistory = _getFilteredHistory();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: filteredHistory.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == filteredHistory.length - 1;
          
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline Line
              Column(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _getTypeColor(item["type"] as String),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Center(
                      child: Icon(
                        _getTypeIcon(item["type"] as String),
                        size: 8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 100,
                      color: disabledOutlineBorderColor,
                    ),
                ],
              ),
              SizedBox(width: spSm),
              // Content
              Expanded(
                child: _buildHistoryCard(item),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildListView() {
    final filteredHistory = _getFilteredHistory();
    
    return ListView.builder(
      padding: EdgeInsets.all(spSm),
      itemCount: filteredHistory.length,
      itemBuilder: (context, index) {
        final item = filteredHistory[index];
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: _buildHistoryCard(item),
        );
      },
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        _openHistoryDetail(item);
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: Column(
          spacing: spSm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getTypeColor(item["type"] as String).withAlpha(32),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    spacing: 4,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getTypeIcon(item["type"] as String),
                        size: 12,
                        color: _getTypeColor(item["type"] as String),
                      ),
                      Text(
                        "${item["type"]}".replaceAll("_", " ").toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getTypeColor(item["type"] as String),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                if (item["favorite"] as bool)
                  Icon(
                    Icons.favorite,
                    size: 16,
                    color: dangerColor,
                  ),
                QButton(
                  icon: Icons.more_vert,
                  size: bs.sm,
                  onPressed: () {
                    _showHistoryOptions(item);
                  },
                ),
              ],
            ),

            // Content
            Row(
              spacing: spSm,
              children: [
                // Before/After Images
                Row(
                  spacing: spXs,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusXs),
                        image: DecorationImage(
                          image: NetworkImage("${item["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusXs),
                        image: DecorationImage(
                          image: NetworkImage("${item["finalImage"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                // Details
                Expanded(
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${item["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        spacing: spSm,
                        children: [
                          Row(
                            spacing: 4,
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 12,
                                color: disabledColor,
                              ),
                              Text(
                                "${item["duration"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${(item["date"] as DateTime).dMMMy}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Tags
            Wrap(
              spacing: spXs,
              children: (item["tags"] as List<String>).take(3).map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(16),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "#$tag",
                    style: TextStyle(
                      fontSize: 9,
                      color: primaryColor,
                    ),
                  ),
                );
              }).toList(),
            ),

            // Actions (if details enabled)
            if (showDetails) ...[
              Row(
                spacing: spXs,
                children: [
                  QButton(
                    label: "Repeat",
                    size: bs.sm,
                    onPressed: () {
                      _repeatActions(item);
                    },
                  ),
                  QButton(
                    label: "Share",
                    size: bs.sm,
                    onPressed: () {
                      _shareHistory(item);
                    },
                  ),
                  QButton(
                    label: "Export",
                    size: bs.sm,
                    onPressed: () {
                      _exportHistory(item);
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "edit_session": return primaryColor;
      case "creation": return successColor;
      case "batch": return warningColor;
      case "restoration": return infoColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "edit_session": return Icons.tune;
      case "creation": return Icons.create;
      case "batch": return Icons.batch_prediction;
      case "restoration": return Icons.restore;
      default: return Icons.edit;
    }
  }

  List<Map<String, dynamic>> _getFilteredHistory() {
    List<Map<String, dynamic>> filtered = historyItems;

    // Apply filter
    if (filterBy != "all") {
      if (filterBy == "favorites") {
        filtered = filtered.where((item) => item["favorite"] as bool).toList();
      } else {
        filtered = filtered.where((item) => item["type"] == filterBy).toList();
      }
    }

    // Apply sort
    switch (sortBy) {
      case "recent":
        filtered.sort((a, b) => (b["date"] as DateTime).compareTo(a["date"] as DateTime));
        break;
      case "oldest":
        filtered.sort((a, b) => (a["date"] as DateTime).compareTo(b["date"] as DateTime));
        break;
      case "duration_long":
        filtered.sort((a, b) => _parseDuration(b["duration"] as String).compareTo(_parseDuration(a["duration"] as String)));
        break;
      case "duration_short":
        filtered.sort((a, b) => _parseDuration(a["duration"] as String).compareTo(_parseDuration(b["duration"] as String)));
        break;
      case "alphabetical":
        filtered.sort((a, b) => (a["title"] as String).compareTo(b["title"] as String));
        break;
    }

    return filtered;
  }

  int _parseDuration(String duration) {
    final number = int.tryParse(duration.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    return duration.contains('min') ? number : number * 60;
  }

  int _getThisWeekCount() {
    final weekAgo = DateTime.now().subtract(Duration(days: 7));
    return historyItems.where((item) => (item["date"] as DateTime).isAfter(weekAgo)).length;
  }

  int _getFavoritesCount() {
    return historyItems.where((item) => item["favorite"] as bool).length;
  }

  String _getTotalTime() {
    int totalMinutes = historyItems.fold(0, (sum, item) => sum + _parseDuration(item["duration"] as String));
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    return hours > 0 ? "${hours}h ${minutes}m" : "${minutes}m";
  }

  void _searchHistory() {
    ss("Search history functionality");
  }

  void _openHistoryDetail(Map<String, dynamic> item) {
    ss("Opening ${item["title"]} details");
  }

  void _showHistoryOptions(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "History Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ListTile(
              leading: Icon(item["favorite"] as bool ? Icons.favorite : Icons.favorite_border),
              title: Text(item["favorite"] as bool ? "Remove from Favorites" : "Add to Favorites"),
              onTap: () {
                back();
                _toggleFavorite(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.repeat),
              title: Text("Repeat Actions"),
              onTap: () {
                back();
                _repeatActions(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share"),
              onTap: () {
                back();
                _shareHistory(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.download),
              title: Text("Export"),
              onTap: () {
                back();
                _exportHistory(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete from History", style: TextStyle(color: dangerColor)),
              onTap: () {
                back();
                _deleteHistory(item);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite(Map<String, dynamic> item) {
    final isFavorite = item["favorite"] as bool;
    ss(isFavorite ? "Removed from favorites" : "Added to favorites");
  }

  void _repeatActions(Map<String, dynamic> item) {
    ss("Repeating actions from ${item["title"]}");
  }

  void _shareHistory(Map<String, dynamic> item) {
    ss("Sharing ${item["title"]}");
  }

  void _exportHistory(Map<String, dynamic> item) {
    ss("Exporting ${item["title"]}");
  }

  void _deleteHistory(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Delete ${item["title"]} from history?");
    if (isConfirmed) {
      ss("Deleted from history");
    }
  }
}
