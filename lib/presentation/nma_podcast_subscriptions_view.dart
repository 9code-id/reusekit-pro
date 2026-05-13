import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaPodcastSubscriptionsView extends StatefulWidget {
  const NmaPodcastSubscriptionsView({super.key});

  @override
  State<NmaPodcastSubscriptionsView> createState() => _NmaPodcastSubscriptionsViewState();
}

class _NmaPodcastSubscriptionsViewState extends State<NmaPodcastSubscriptionsView> {
  String selectedCategory = "All";
  String sortBy = "Recently Updated";
  bool showUnplayedOnly = false;

  List<Map<String, dynamic>> subscriptions = [
    {
      "id": "1",
      "title": "The Daily Finance Report",
      "host": "Sarah Mitchell",
      "description": "Daily insights into market movements, economic trends, and financial news that matters to your portfolio.",
      "image": "https://picsum.photos/300/300?random=1&keyword=finance",
      "category": "Finance",
      "subscribedAt": DateTime.now().subtract(Duration(days: 30)),
      "lastEpisode": "Fed Policy Impact on Tech Stocks",
      "lastEpisodeDate": DateTime.now().subtract(Duration(hours: 2)),
      "unplayedCount": 3,
      "totalEpisodes": 245,
      "avgDuration": "25 min",
      "rating": 4.8,
      "isAutoDownload": true,
      "notificationsEnabled": true,
      "tags": ["Markets", "Economics", "Investment"]
    },
    {
      "id": "2",
      "title": "Crypto Weekly",
      "host": "Alex Thompson",
      "description": "Your weekly dose of cryptocurrency news, analysis, and market predictions from industry experts.",
      "image": "https://picsum.photos/300/300?random=2&keyword=crypto",
      "category": "Cryptocurrency",
      "subscribedAt": DateTime.now().subtract(Duration(days: 45)),
      "lastEpisode": "Bitcoin ETF Impact Analysis",
      "lastEpisodeDate": DateTime.now().subtract(Duration(days: 3)),
      "unplayedCount": 1,
      "totalEpisodes": 98,
      "avgDuration": "35 min",
      "rating": 4.5,
      "isAutoDownload": false,
      "notificationsEnabled": true,
      "tags": ["Bitcoin", "DeFi", "Blockchain"]
    },
    {
      "id": "3",
      "title": "Global Economics Hour",
      "host": "Dr. James Park",
      "description": "In-depth analysis of global economic trends, policy changes, and their impact on international markets.",
      "image": "https://picsum.photos/300/300?random=3&keyword=economics",
      "category": "Economics",
      "subscribedAt": DateTime.now().subtract(Duration(days: 60)),
      "lastEpisode": "Trade Wars and Supply Chains",
      "lastEpisodeDate": DateTime.now().subtract(Duration(days: 2)),
      "unplayedCount": 2,
      "totalEpisodes": 87,
      "avgDuration": "50 min",
      "rating": 4.7,
      "isAutoDownload": true,
      "notificationsEnabled": false,
      "tags": ["Global Trade", "Policy", "Macroeconomics"]
    },
    {
      "id": "4",
      "title": "Tech Talk Today",
      "host": "Emma Wilson",
      "description": "Latest technology trends, product launches, and industry analysis from Silicon Valley and beyond.",
      "image": "https://picsum.photos/300/300?random=4&keyword=technology",
      "category": "Technology",
      "subscribedAt": DateTime.now().subtract(Duration(days: 15)),
      "lastEpisode": "AI Revolution in Healthcare",
      "lastEpisodeDate": DateTime.now().subtract(Duration(hours: 12)),
      "unplayedCount": 5,
      "totalEpisodes": 312,
      "avgDuration": "30 min",
      "rating": 4.9,
      "isAutoDownload": false,
      "notificationsEnabled": true,
      "tags": ["AI", "Innovation", "Silicon Valley"]
    },
    {
      "id": "5",
      "title": "Startup Stories",
      "host": "Mike Chen & Lisa Rodriguez",
      "description": "Conversations with founders, VCs, and entrepreneurs about building successful companies in today's market.",
      "image": "https://picsum.photos/300/300?random=5&keyword=startup",
      "category": "Business",
      "subscribedAt": DateTime.now().subtract(Duration(days: 90)),
      "lastEpisode": "Scaling SaaS: From 0 to 100M ARR",
      "lastEpisodeDate": DateTime.now().subtract(Duration(days: 1)),
      "unplayedCount": 0,
      "totalEpisodes": 156,
      "avgDuration": "45 min",
      "rating": 4.6,
      "isAutoDownload": true,
      "notificationsEnabled": true,
      "tags": ["Startups", "Entrepreneurship", "VC"]
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Business", "value": "Business"},
    {"label": "Cryptocurrency", "value": "Cryptocurrency"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Economics", "value": "Economics"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recently Updated", "value": "Recently Updated"},
    {"label": "Recently Subscribed", "value": "Recently Subscribed"},
    {"label": "Alphabetical", "value": "Alphabetical"},
    {"label": "Most Unplayed", "value": "Most Unplayed"},
    {"label": "Highest Rated", "value": "Highest Rated"},
  ];

  List<Map<String, dynamic>> get filteredAndSortedSubscriptions {
    var filtered = subscriptions.where((subscription) {
      final matchesCategory = selectedCategory == "All" || subscription["category"] == selectedCategory;
      final matchesUnplayed = !showUnplayedOnly || (subscription["unplayedCount"] as int) > 0;
      return matchesCategory && matchesUnplayed;
    }).toList();

    // Sort subscriptions
    switch (sortBy) {
      case "Recently Subscribed":
        filtered.sort((a, b) => (b["subscribedAt"] as DateTime).compareTo(a["subscribedAt"] as DateTime));
        break;
      case "Alphabetical":
        filtered.sort((a, b) => (a["title"] as String).compareTo(b["title"] as String));
        break;
      case "Most Unplayed":
        filtered.sort((a, b) => (b["unplayedCount"] as int).compareTo(a["unplayedCount"] as int));
        break;
      case "Highest Rated":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      default: // Recently Updated
        filtered.sort((a, b) => (b["lastEpisodeDate"] as DateTime).compareTo(a["lastEpisodeDate"] as DateTime));
        break;
    }

    return filtered;
  }

  void _unsubscribe(String subscriptionId) async {
    bool isConfirmed = await confirm("Are you sure you want to unsubscribe from this podcast?");
    if (isConfirmed) {
      subscriptions.removeWhere((subscription) => subscription["id"] == subscriptionId);
      setState(() {});
      ss("Successfully unsubscribed from podcast");
    }
  }

  void _toggleAutoDownload(String subscriptionId) {
    final subscriptionIndex = subscriptions.indexWhere((subscription) => subscription["id"] == subscriptionId);
    if (subscriptionIndex != -1) {
      subscriptions[subscriptionIndex]["isAutoDownload"] = !(subscriptions[subscriptionIndex]["isAutoDownload"] as bool);
      setState(() {});
    }
  }

  void _toggleNotifications(String subscriptionId) {
    final subscriptionIndex = subscriptions.indexWhere((subscription) => subscription["id"] == subscriptionId);
    if (subscriptionIndex != -1) {
      subscriptions[subscriptionIndex]["notificationsEnabled"] = !(subscriptions[subscriptionIndex]["notificationsEnabled"] as bool);
      setState(() {});
    }
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
    } else {
      return "${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredSubscriptions = filteredAndSortedSubscriptions;
    final totalUnplayed = subscriptions.fold(0, (sum, sub) => sum + (sub["unplayedCount"] as int));

    return Scaffold(
      appBar: AppBar(
        title: Text("My Subscriptions"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Open search
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Open subscription settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter & Sort",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
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
                          label: "Sort By",
                          items: sortOptions,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Show only podcasts with unplayed episodes",
                        "value": true,
                        "checked": showUnplayedOnly,
                      }
                    ],
                    value: showUnplayedOnly ? [
                      {
                        "label": "Show only podcasts with unplayed episodes",
                        "value": true,
                        "checked": true
                      }
                    ] : [],
                    onChanged: (values, ids) {
                      showUnplayedOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "${subscriptions.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Subscriptions",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(100),
                  ),
                  Column(
                    children: [
                      Text(
                        "$totalUnplayed",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Unplayed",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(100),
                  ),
                  Column(
                    children: [
                      Text(
                        "${subscriptions.where((s) => s["isAutoDownload"] as bool).length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Auto Download",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Play All Unplayed",
                          size: bs.sm,
                          onPressed: () {
                            // Play all unplayed episodes
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Mark All as Played",
                          size: bs.sm,
                          onPressed: () {
                            // Mark all as played
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Download New Episodes",
                          size: bs.sm,
                          onPressed: () {
                            // Download all new episodes
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Manage Storage",
                          size: bs.sm,
                          onPressed: () {
                            // Manage storage
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Subscriptions List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Podcasts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${filteredSubscriptions.length} podcasts",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            // Subscriptions List
            if (filteredSubscriptions.isNotEmpty) ...[
              ...filteredSubscriptions.map((subscription) {
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
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            // Podcast Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Stack(
                                children: [
                                  Image.network(
                                    "${subscription["image"]}",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  if ((subscription["unplayedCount"] as int) > 0) ...[
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: dangerColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          "${subscription["unplayedCount"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),

                            // Podcast Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(50),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${subscription["category"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Show more options
                                        },
                                        child: Icon(
                                          Icons.more_vert,
                                          color: disabledBoldColor,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: spXs),

                                  Text(
                                    "${subscription["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  Text(
                                    "by ${subscription["host"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  SizedBox(height: spXs),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: warningColor,
                                        size: 14,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${(subscription["rating"] as double).toStringAsFixed(1)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${subscription["totalEpisodes"]} episodes",
                                        style: TextStyle(
                                          fontSize: 12,
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
                      ),

                      // Latest Episode Info
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Latest Episode",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${subscription["lastEpisode"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                _getTimeAgo(subscription["lastEpisodeDate"] as DateTime),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Settings Row
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => _toggleAutoDownload("${subscription["id"]}"),
                                  child: Row(
                                    children: [
                                      Icon(
                                        (subscription["isAutoDownload"] as bool) 
                                            ? Icons.download 
                                            : Icons.download_outlined,
                                        color: (subscription["isAutoDownload"] as bool) 
                                            ? primaryColor 
                                            : disabledBoldColor,
                                        size: 20,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Auto",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: (subscription["isAutoDownload"] as bool) 
                                              ? primaryColor 
                                              : disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () => _toggleNotifications("${subscription["id"]}"),
                                  child: Row(
                                    children: [
                                      Icon(
                                        (subscription["notificationsEnabled"] as bool) 
                                            ? Icons.notifications 
                                            : Icons.notifications_off,
                                        color: (subscription["notificationsEnabled"] as bool) 
                                            ? primaryColor 
                                            : disabledBoldColor,
                                        size: 20,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Notify",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: (subscription["notificationsEnabled"] as bool) 
                                              ? primaryColor 
                                              : disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Subscribed ${_getTimeAgo(subscription["subscribedAt"] as DateTime)}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Action Buttons
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: (subscription["unplayedCount"] as int) > 0 
                                    ? "Play New (${subscription["unplayedCount"]})" 
                                    : "View Episodes",
                                size: bs.sm,
                                onPressed: () {
                                  // Navigate to episodes or play
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () => _unsubscribe("${subscription["id"]}"),
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.unsubscribe,
                                  size: 20,
                                  color: dangerColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ] else ...[
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.podcasts,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      showUnplayedOnly 
                          ? "No podcasts with unplayed episodes"
                          : "No subscriptions found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      showUnplayedOnly 
                          ? "Try turning off the unplayed filter"
                          : "Subscribe to podcasts to see them here",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (!showUnplayedOnly) ...[
                      SizedBox(height: spMd),
                      QButton(
                        label: "Discover Podcasts",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to discover podcasts
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
