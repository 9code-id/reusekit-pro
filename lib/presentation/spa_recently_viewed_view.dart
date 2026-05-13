import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaRecentlyViewedView extends StatefulWidget {
  const SpaRecentlyViewedView({Key? key}) : super(key: key);

  @override
  State<SpaRecentlyViewedView> createState() => _SpaRecentlyViewedViewState();
}

class _SpaRecentlyViewedViewState extends State<SpaRecentlyViewedView> {
  String viewFilter = "all";
  bool showTimestamps = true;

  List<Map<String, dynamic>> recentlyViewed = [
    {
      "id": 1,
      "title": "Diamond Radiance Facial",
      "price": 350.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=diamond",
      "spa": "Luxury Crystal Spa",
      "category": "facial",
      "rating": 4.9,
      "reviews": 156,
      "viewedAt": "2024-06-17T14:30:00",
      "duration": "75 min",
      "distance": 2.1,
      "isFavorite": false,
      "isAvailable": true,
      "viewCount": 3,
    },
    {
      "id": 2,
      "title": "Hot Stone Deep Massage",
      "price": 240.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=stones",
      "spa": "Mountain Zen Retreat",
      "category": "massage",
      "rating": 4.7,
      "reviews": 289,
      "viewedAt": "2024-06-17T11:15:00",
      "duration": "90 min",
      "distance": 3.5,
      "isFavorite": true,
      "isAvailable": true,
      "viewCount": 2,
    },
    {
      "id": 3,
      "title": "Couples Romance Package",
      "price": 680.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=romantic",
      "spa": "Love & Luxury Spa",
      "category": "package",
      "rating": 4.8,
      "reviews": 98,
      "viewedAt": "2024-06-16T16:45:00",
      "duration": "2.5 hours",
      "distance": 4.2,
      "isFavorite": false,
      "isAvailable": false,
      "viewCount": 1,
    },
    {
      "id": 4,
      "title": "Anti-cellulite Body Treatment",
      "price": 195.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=body",
      "spa": "Body Sculpt Center",
      "category": "body",
      "rating": 4.5,
      "reviews": 167,
      "viewedAt": "2024-06-16T09:20:00",
      "duration": "60 min",
      "distance": 1.8,
      "isFavorite": false,
      "isAvailable": true,
      "viewCount": 1,
    },
    {
      "id": 5,
      "title": "Luxury Manicure & Pedicure",
      "price": 125.0,
      "image": "https://picsum.photos/300/200?random=5&keyword=nails",
      "spa": "Nail Artistry Studio",
      "category": "nails",
      "rating": 4.6,
      "reviews": 224,
      "viewedAt": "2024-06-15T18:30:00",
      "duration": "90 min",
      "distance": 2.7,
      "isFavorite": true,
      "isAvailable": true,
      "viewCount": 4,
    },
    {
      "id": 6,
      "title": "Hydrating Oxygen Facial",
      "price": 180.0,
      "image": "https://picsum.photos/300/200?random=6&keyword=oxygen",
      "spa": "Fresh Air Beauty",
      "category": "facial",
      "rating": 4.4,
      "reviews": 178,
      "viewedAt": "2024-06-15T13:10:00",
      "duration": "60 min",
      "distance": 3.1,
      "isFavorite": false,
      "isAvailable": true,
      "viewCount": 2,
    },
    {
      "id": 7,
      "title": "Prenatal Wellness Massage",
      "price": 160.0,
      "image": "https://picsum.photos/300/200?random=7&keyword=prenatal",
      "spa": "Motherhood Spa",
      "category": "massage",
      "rating": 4.8,
      "reviews": 134,
      "viewedAt": "2024-06-14T15:25:00",
      "duration": "60 min",
      "distance": 2.9,
      "isFavorite": false,
      "isAvailable": true,
      "viewCount": 1,
    },
    {
      "id": 8,
      "title": "Detox Herbal Body Wrap",
      "price": 145.0,
      "image": "https://picsum.photos/300/200?random=8&keyword=herbal",
      "spa": "Nature's Touch Spa",
      "category": "body",
      "rating": 4.3,
      "reviews": 89,
      "viewedAt": "2024-06-14T10:05:00",
      "duration": "75 min",
      "distance": 4.5,
      "isFavorite": false,
      "isAvailable": true,
      "viewCount": 1,
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Items", "value": "all"},
    {"label": "Today", "value": "today"},
    {"label": "Yesterday", "value": "yesterday"},
    {"label": "This Week", "value": "week"},
    {"label": "Favorites Only", "value": "favorites"},
    {"label": "Available Now", "value": "available"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recently Viewed"),
        actions: [
          QButton(
            icon: Icons.clear_all,
            size: bs.sm,
            onPressed: () {
              _showClearHistoryDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Recently Viewed Header
          _buildRecentlyViewedHeader(),

          // Filter Controls
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Column(
              spacing: spSm,
              children: [
                QDropdownField(
                  label: "Filter by",
                  items: filterOptions,
                  value: viewFilter,
                  onChanged: (value, label) {
                    viewFilter = value;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Show viewing timestamps",
                      "value": "timestamps",
                      "checked": showTimestamps,
                    }
                  ],
                  value: showTimestamps
                      ? [
                          {
                            "label": "Show viewing timestamps",
                            "value": "timestamps",
                            "checked": true,
                          }
                        ]
                      : [],
                  onChanged: (values, ids) {
                    showTimestamps = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Recently Viewed List
          Expanded(
            child: _getFilteredItems().isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: _getFilteredItems().length,
                    itemBuilder: (context, index) {
                      final item = _getFilteredItems()[index];
                      return _buildRecentlyViewedCard(item, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewedHeader() {
    int totalItems = recentlyViewed.length;
    int todayItems = _getItemsFromToday().length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [infoColor, infoColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.history, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recently Viewed",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Your browsing history for easy re-booking",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Quick Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickStat("Total", totalItems),
              _buildQuickStat("Today", todayItems),
              _buildQuickStat("Favorites", _getFavorites().length),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String label, int count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(51),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(230),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewedCard(Map<String, dynamic> item, int index) {
    DateTime viewedAt = DateTime.parse(item["viewedAt"]);
    String timeAgo = _getTimeAgo(viewedAt);
    bool isAvailable = item["isAvailable"] as bool;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: !isAvailable 
            ? Border.all(color: disabledColor, width: 1)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Status
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: ColorFiltered(
                  colorFilter: !isAvailable
                      ? ColorFilter.mode(Colors.grey, BlendMode.saturation)
                      : ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                  child: Image.network(
                    "${item["image"]}",
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // View Count Badge
              if ((item["viewCount"] as int) > 1)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Viewed ${item["viewCount"]}x",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              // Favorite Button
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () {
                    _toggleFavorite(item["id"]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                      color: item["isFavorite"] ? dangerColor : disabledBoldColor,
                      size: 20,
                    ),
                  ),
                ),
              ),

              // Unavailable Overlay
              if (!isAvailable)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(127),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    ),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "UNAVAILABLE",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Index and Time Viewed
                if (showTimestamps)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "#${index + 1}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        timeAgo,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),

                // Title and Spa
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: !isAvailable ? disabledBoldColor : null,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["spa"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Price, Duration, and Rating
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${((item["price"] as double)).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: !isAvailable ? disabledBoldColor : primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${item["duration"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${item["rating"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: !isAvailable ? disabledBoldColor : null,
                              ),
                            ),
                            Text(
                              " (${item["reviews"]})",
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
                            Icon(Icons.location_on, color: disabledBoldColor, size: 14),
                            SizedBox(width: spXs),
                            Text(
                              "${item["distance"]} km",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Action Buttons
                Row(
                  children: [
                    if (isAvailable) ...[
                      Expanded(
                        child: QButton(
                          label: "Book Again",
                          size: bs.sm,
                          onPressed: () {
                            _bookAgain(item);
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.info,
                        size: bs.sm,
                        color: secondaryColor,
                        onPressed: () {
                          _viewDetails(item);
                        },
                      ),
                    ] else ...[
                      Expanded(
                        child: QButton(
                          label: "Find Similar",
                          size: bs.sm,
                          color: secondaryColor,
                          onPressed: () {
                            _findSimilar(item);
                          },
                        ),
                      ),
                    ],
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.delete,
                      size: bs.sm,
                      color: dangerColor,
                      onPressed: () {
                        _removeFromHistory(item["id"]);
                      },
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: disabledBoldColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No items match your filter",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Try changing your filter settings",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Browse Treatments",
            size: bs.sm,
            onPressed: () {
              //navigateTo ( SpaTreatmentsView )
            },
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredItems() {
    List<Map<String, dynamic>> filtered = List.from(recentlyViewed);

    switch (viewFilter) {
      case "today":
        filtered = _getItemsFromToday();
        break;
      case "yesterday":
        filtered = _getItemsFromYesterday();
        break;
      case "week":
        filtered = _getItemsFromWeek();
        break;
      case "favorites":
        filtered = _getFavorites();
        break;
      case "available":
        filtered = filtered.where((item) => item["isAvailable"] as bool).toList();
        break;
    }

    return filtered;
  }

  List<Map<String, dynamic>> _getItemsFromToday() {
    DateTime today = DateTime.now();
    return recentlyViewed.where((item) {
      DateTime viewedAt = DateTime.parse(item["viewedAt"]);
      return viewedAt.year == today.year &&
             viewedAt.month == today.month &&
             viewedAt.day == today.day;
    }).toList();
  }

  List<Map<String, dynamic>> _getItemsFromYesterday() {
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    return recentlyViewed.where((item) {
      DateTime viewedAt = DateTime.parse(item["viewedAt"]);
      return viewedAt.year == yesterday.year &&
             viewedAt.month == yesterday.month &&
             viewedAt.day == yesterday.day;
    }).toList();
  }

  List<Map<String, dynamic>> _getItemsFromWeek() {
    DateTime weekAgo = DateTime.now().subtract(Duration(days: 7));
    return recentlyViewed.where((item) {
      DateTime viewedAt = DateTime.parse(item["viewedAt"]);
      return viewedAt.isAfter(weekAgo);
    }).toList();
  }

  List<Map<String, dynamic>> _getFavorites() {
    return recentlyViewed.where((item) => item["isFavorite"] as bool).toList();
  }

  String _getTimeAgo(DateTime viewedAt) {
    Duration difference = DateTime.now().difference(viewedAt);
    
    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m ago";
    } else {
      return "Just now";
    }
  }

  void _showClearHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Clear History"),
          content: Text("Are you sure you want to clear all your recently viewed items? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _clearAllHistory();
                Navigator.pop(context);
              },
              child: Text("Clear All", style: TextStyle(color: dangerColor)),
            ),
          ],
        );
      },
    );
  }

  void _clearAllHistory() {
    setState(() {
      recentlyViewed.clear();
    });
    ss("History cleared successfully");
  }

  void _toggleFavorite(int itemId) {
    setState(() {
      final index = recentlyViewed.indexWhere((item) => item["id"] == itemId);
      if (index != -1) {
        recentlyViewed[index]["isFavorite"] = !(recentlyViewed[index]["isFavorite"] as bool);
      }
    });

    bool isFavorite = recentlyViewed.firstWhere((item) => item["id"] == itemId)["isFavorite"];
    if (isFavorite) {
      ss("Added to favorites");
    } else {
      si("Removed from favorites");
    }
  }

  void _bookAgain(Map<String, dynamic> item) {
    ss("Booking ${item["title"]} again...");
    //navigateTo ( SpaBookingView )
  }

  void _viewDetails(Map<String, dynamic> item) {
    si("Viewing details for ${item["title"]}");
    //navigateTo ( SpaTreatmentDetailView )
  }

  void _findSimilar(Map<String, dynamic> item) {
    si("Finding similar treatments to ${item["title"]}");
    //navigateTo ( SpaSimilarTreatmentsView )
  }

  void _removeFromHistory(int itemId) {
    setState(() {
      recentlyViewed.removeWhere((item) => item["id"] == itemId);
    });
    si("Removed from history");
  }
}
