import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaHistoryView extends StatefulWidget {
  const NmaHistoryView({super.key});

  @override
  State<NmaHistoryView> createState() => _NmaHistoryViewState();
}

class _NmaHistoryViewState extends State<NmaHistoryView> {
  String selectedTimeFilter = "All Time";
  String selectedTypeFilter = "All";
  String searchQuery = "";
  bool isListView = true;
  bool isSelectionMode = false;
  List<String> selectedItems = [];

  List<Map<String, dynamic>> timeFilters = [
    {"label": "All Time", "value": "All Time"},
    {"label": "Today", "value": "Today"},
    {"label": "Yesterday", "value": "Yesterday"},
    {"label": "This Week", "value": "This Week"},
    {"label": "Last Week", "value": "Last Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All", "value": "All", "count": 156},
    {"label": "Articles Read", "value": "read", "count": 89},
    {"label": "Searches", "value": "search", "count": 34},
    {"label": "Bookmarks", "value": "bookmark", "count": 18},
    {"label": "Shares", "value": "share", "count": 15},
  ];

  List<Map<String, dynamic>> historyItems = [
    {
      "id": "1",
      "type": "read",
      "title": "The Future of Artificial Intelligence",
      "source": "MIT Technology Review",
      "author": "Dr. Sarah Johnson",
      "timestamp": "2024-01-15 14:30",
      "timeAgo": "2 hours ago",
      "duration": "12 min read",
      "readProgress": 100,
      "image": "https://picsum.photos/400/250?random=1&keyword=ai",
      "category": "Technology",
      "tags": ["AI", "Technology", "Future"],
    },
    {
      "id": "2",
      "type": "search",
      "query": "quantum computing breakthrough 2024",
      "timestamp": "2024-01-15 13:45",
      "timeAgo": "3 hours ago",
      "resultsCount": 42,
      "category": "Search",
    },
    {
      "id": "3",
      "type": "read",
      "title": "Climate Change Solutions That Work",
      "source": "National Geographic",
      "author": "Dr. Emma Wilson",
      "timestamp": "2024-01-15 11:20",
      "timeAgo": "5 hours ago",
      "duration": "8 min read",
      "readProgress": 75,
      "image": "https://picsum.photos/400/250?random=3&keyword=climate",
      "category": "Science",
      "tags": ["Climate", "Environment", "Solutions"],
    },
    {
      "id": "4",
      "type": "bookmark",
      "title": "Remote Work Best Practices",
      "source": "Harvard Business Review",
      "author": "Lisa Park",
      "timestamp": "2024-01-15 10:15",
      "timeAgo": "6 hours ago",
      "duration": "6 min read",
      "image": "https://picsum.photos/400/250?random=4&keyword=remote",
      "category": "Business",
      "tags": ["Remote Work", "Productivity", "Business"],
    },
    {
      "id": "5",
      "type": "search",
      "query": "machine learning algorithms explained",
      "timestamp": "2024-01-15 09:30",
      "timeAgo": "7 hours ago",
      "resultsCount": 156,
      "category": "Search",
    },
    {
      "id": "6",
      "type": "share",
      "title": "The Psychology of Decision Making",
      "source": "Psychology Today",
      "author": "Dr. Michael Chen",
      "timestamp": "2024-01-14 16:45",
      "timeAgo": "Yesterday",
      "duration": "10 min read",
      "sharedTo": "Twitter, LinkedIn",
      "image": "https://picsum.photos/400/250?random=6&keyword=psychology",
      "category": "Psychology",
      "tags": ["Psychology", "Decision Making", "Behavior"],
    },
    {
      "id": "7",
      "type": "read",
      "title": "Breakthrough in Gene Therapy",
      "source": "Nature Medicine",
      "author": "Dr. Robert Davis",
      "timestamp": "2024-01-14 14:20",
      "timeAgo": "Yesterday",
      "duration": "15 min read",
      "readProgress": 45,
      "image": "https://picsum.photos/400/250?random=7&keyword=medicine",
      "category": "Medicine",
      "tags": ["Gene Therapy", "Medicine", "Research"],
    },
    {
      "id": "8",
      "type": "search",
      "query": "sustainable energy innovations",
      "timestamp": "2024-01-14 12:10",
      "timeAgo": "Yesterday",
      "resultsCount": 78,
      "category": "Search",
    },
    {
      "id": "9",
      "type": "bookmark",
      "title": "The Art of Mindful Living",
      "source": "Mindfulness Magazine",
      "author": "Anna Thompson",
      "timestamp": "2024-01-14 11:30",
      "timeAgo": "Yesterday",
      "duration": "7 min read",
      "image": "https://picsum.photos/400/250?random=9&keyword=mindfulness",
      "category": "Lifestyle",
      "tags": ["Mindfulness", "Wellness", "Lifestyle"],
    },
    {
      "id": "10",
      "type": "read",
      "title": "Space Exploration: Mars Mission Update",
      "source": "Space News",
      "author": "Commander Alex Rodriguez",
      "timestamp": "2024-01-13 15:45",
      "timeAgo": "2 days ago",
      "duration": "11 min read",
      "readProgress": 100,
      "image": "https://picsum.photos/400/250?random=10&keyword=space",
      "category": "Space",
      "tags": ["Space", "Mars", "Exploration"],
    },
  ];

  List<Map<String, dynamic>> get filteredHistory {
    List<Map<String, dynamic>> filtered = historyItems;

    if (selectedTypeFilter != "All") {
      filtered = filtered.where((item) => item["type"] == selectedTypeFilter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        if (item["type"] == "search") {
          return (item["query"] as String).toLowerCase().contains(searchQuery.toLowerCase());
        } else {
          return (item["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
              (item["source"] as String).toLowerCase().contains(searchQuery.toLowerCase());
        }
      }).toList();
    }

    return filtered;
  }

  Map<String, List<Map<String, dynamic>>> get groupedHistory {
    Map<String, List<Map<String, dynamic>>> grouped = {};
    
    for (var item in filteredHistory) {
      String dateKey = _getDateGroup(item["timestamp"]);
      
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(item);
    }
    
    return grouped;
  }

  String _getDateGroup(String timestamp) {
    DateTime itemDate = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime itemDay = DateTime(itemDate.year, itemDate.month, itemDate.day);

    if (itemDay == today) {
      return "Today";
    } else if (itemDay == yesterday) {
      return "Yesterday";
    } else if (now.difference(itemDate).inDays < 7) {
      return "This Week";
    } else if (now.difference(itemDate).inDays < 30) {
      return "This Month";
    } else {
      return "Older";
    }
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Text(
                    "Filter History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Time Period",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Select Time Period",
                      items: timeFilters,
                      value: selectedTimeFilter,
                      onChanged: (value, label) {
                        selectedTimeFilter = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spLg),
                    Text(
                      "Activity Type",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...typeFilters.map((filter) {
                      bool isSelected = selectedTypeFilter == filter["value"];
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: GestureDetector(
                          onTap: () {
                            selectedTypeFilter = filter["value"];
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${filter["label"]}",
                                  style: TextStyle(
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${filter["count"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Reset",
                      color: disabledColor,
                      size: bs.md,
                      onPressed: () {
                        selectedTimeFilter = "All Time";
                        selectedTypeFilter = "All";
                        setState(() {});
                        Navigator.pop(context);
                        ss("Filters reset successfully");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Apply",
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Filters applied successfully");
                      },
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

  void _showBulkActions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Text(
                    "Bulk Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${selectedItems.length} selected",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  _buildBulkActionItem(
                    icon: Icons.bookmark_add,
                    title: "Bookmark Selected",
                    onTap: () {
                      Navigator.pop(context);
                      ss("${selectedItems.length} items bookmarked");
                      _exitSelectionMode();
                    },
                  ),
                  _buildBulkActionItem(
                    icon: Icons.favorite,
                    title: "Add to Favorites",
                    onTap: () {
                      Navigator.pop(context);
                      ss("${selectedItems.length} items added to favorites");
                      _exitSelectionMode();
                    },
                  ),
                  _buildBulkActionItem(
                    icon: Icons.share,
                    title: "Share Selected",
                    onTap: () {
                      Navigator.pop(context);
                      si("Sharing ${selectedItems.length} items");
                      _exitSelectionMode();
                    },
                  ),
                  _buildBulkActionItem(
                    icon: Icons.download,
                    title: "Export History",
                    onTap: () {
                      Navigator.pop(context);
                      ss("History exported successfully");
                      _exitSelectionMode();
                    },
                  ),
                  _buildBulkActionItem(
                    icon: Icons.delete,
                    title: "Remove from History",
                    color: dangerColor,
                    onTap: () async {
                      Navigator.pop(context);
                      bool isConfirmed = await confirm("Remove ${selectedItems.length} items from history?");
                      if (isConfirmed) {
                        ss("${selectedItems.length} items removed from history");
                        _exitSelectionMode();
                      }
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

  Widget _buildBulkActionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? primaryColor,
              size: 24,
            ),
            SizedBox(width: spMd),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color ?? Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleSelection(String itemId) {
    if (selectedItems.contains(itemId)) {
      selectedItems.remove(itemId);
    } else {
      selectedItems.add(itemId);
    }
    
    if (selectedItems.isEmpty) {
      isSelectionMode = false;
    }
    
    setState(() {});
  }

  void _exitSelectionMode() {
    isSelectionMode = false;
    selectedItems.clear();
    setState(() {});
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "read":
        return Icons.article;
      case "search":
        return Icons.search;
      case "bookmark":
        return Icons.bookmark;
      case "share":
        return Icons.share;
      default:
        return Icons.history;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "read":
        return primaryColor;
      case "search":
        return infoColor;
      case "bookmark":
        return warningColor;
      case "share":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildHistoryItem(Map<String, dynamic> item) {
    bool isSelected = selectedItems.contains(item["id"]);
    String type = item["type"];
    
    return GestureDetector(
      onTap: () {
        if (isSelectionMode) {
          _toggleSelection(item["id"]);
        } else {
          if (type == "read" || type == "bookmark" || type == "share") {
            // Navigate to article
          } else if (type == "search") {
            // Perform search again
            si("Searching for: ${item["query"]}");
          }
        }
      },
      onLongPress: () {
        if (!isSelectionMode) {
          isSelectionMode = true;
          _toggleSelection(item["id"]);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            if (isSelectionMode)
              Container(
                width: 24,
                height: 24,
                margin: EdgeInsets.only(right: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledColor,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
              ),
            Container(
              width: 48,
              height: 48,
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: _getTypeColor(type).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                _getTypeIcon(type),
                color: _getTypeColor(type),
                size: 24,
              ),
            ),
            if (type != "search" && item["image"] != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusXs),
                child: Image.network(
                  "${item["image"]}",
                  width: 60,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == "search") ...[
                    Text(
                      "Search: ${item["query"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${item["resultsCount"]} results found",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ] else ...[
                    Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          "${item["source"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (item["duration"] != null) ...[
                          SizedBox(width: spXs),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${item["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "${item["timeAgo"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (type == "read" && item["readProgress"] != null) ...[
                        Spacer(),
                        Text(
                          "${item["readProgress"]}% read",
                          style: TextStyle(
                            fontSize: 12,
                            color: item["readProgress"] == 100 ? successColor : primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      if (type == "share" && item["sharedTo"] != null) ...[
                        Spacer(),
                        Text(
                          "Shared to ${item["sharedTo"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (!isSelectionMode)
              GestureDetector(
                onTap: () {
                  _showItemOptions(item);
                },
                child: Icon(
                  Icons.more_vert,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showItemOptions(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Text(
                    "Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  if (item["type"] != "search") ...[
                    _buildItemOption(
                      icon: Icons.bookmark_add,
                      title: "Bookmark",
                      onTap: () {
                        Navigator.pop(context);
                        ss("Article bookmarked");
                      },
                    ),
                    _buildItemOption(
                      icon: Icons.favorite_border,
                      title: "Add to Favorites",
                      onTap: () {
                        Navigator.pop(context);
                        ss("Added to favorites");
                      },
                    ),
                  ],
                  if (item["type"] == "search")
                    _buildItemOption(
                      icon: Icons.search,
                      title: "Search Again",
                      onTap: () {
                        Navigator.pop(context);
                        si("Searching for: ${item["query"]}");
                      },
                    ),
                  _buildItemOption(
                    icon: Icons.share,
                    title: "Share",
                    onTap: () {
                      Navigator.pop(context);
                      si("Sharing item");
                    },
                  ),
                  _buildItemOption(
                    icon: Icons.delete,
                    title: "Remove from History",
                    color: dangerColor,
                    onTap: () async {
                      Navigator.pop(context);
                      bool isConfirmed = await confirm("Remove this item from history?");
                      if (isConfirmed) {
                        ss("Item removed from history");
                      }
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

  Widget _buildItemOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? primaryColor,
              size: 24,
            ),
            SizedBox(width: spMd),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color ?? Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectionMode ? "${selectedItems.length} Selected" : "Reading History"),
        leading: isSelectionMode
            ? GestureDetector(
                onTap: _exitSelectionMode,
                child: Icon(Icons.close),
              )
            : null,
        actions: isSelectionMode
            ? [
                GestureDetector(
                  onTap: () {
                    if (selectedItems.length == filteredHistory.length) {
                      selectedItems.clear();
                    } else {
                      selectedItems = filteredHistory.map((item) => item["id"] as String).toList();
                    }
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Icon(
                      selectedItems.length == filteredHistory.length
                          ? Icons.deselect
                          : Icons.select_all,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _showBulkActions,
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Icon(Icons.more_vert),
                  ),
                ),
              ]
            : [
                GestureDetector(
                  onTap: () {
                    isListView = !isListView;
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Icon(isListView ? Icons.view_compact : Icons.view_list),
                  ),
                ),
                GestureDetector(
                  onTap: _showFilterOptions,
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Icon(Icons.filter_list),
                  ),
                ),
              ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search history...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                if (searchQuery.isNotEmpty) ...[
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () {
                      searchQuery = "";
                      setState(() {});
                    },
                    child: Icon(
                      Icons.clear,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: Colors.grey[50],
            child: Row(
              children: [
                Icon(
                  Icons.history,
                  color: disabledBoldColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${filteredHistory.length} items",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (selectedTypeFilter != "All") ...[
                  SizedBox(width: spXs),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Type: ${typeFilters.firstWhere((f) => f["value"] == selectedTypeFilter)["label"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    bool isConfirmed = await confirm("Clear all reading history?");
                    if (isConfirmed) {
                      ss("Reading history cleared");
                    }
                  },
                  child: Text(
                    "Clear All",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: groupedHistory.keys.length,
              itemBuilder: (context, sectionIndex) {
                String dateGroup = groupedHistory.keys.elementAt(sectionIndex);
                List<Map<String, dynamic>> items = groupedHistory[dateGroup]!;
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (sectionIndex > 0) SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      child: Text(
                        dateGroup,
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    ...items.map((item) => _buildHistoryItem(item)).toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
