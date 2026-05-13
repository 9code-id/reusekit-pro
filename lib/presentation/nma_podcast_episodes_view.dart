import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaPodcastEpisodesView extends StatefulWidget {
  const NmaPodcastEpisodesView({super.key});

  @override
  State<NmaPodcastEpisodesView> createState() => _NmaPodcastEpisodesViewState();
}

class _NmaPodcastEpisodesViewState extends State<NmaPodcastEpisodesView> {
  String selectedSeason = "Season 5";
  String sortBy = "Newest First";
  String filterBy = "All Episodes";
  bool isGridView = false;

  List<Map<String, dynamic>> episodes = [
    {
      "id": "ep015",
      "title": "Fed Policy Impact on Tech Stocks",
      "description": "Analyzing how the Federal Reserve's latest policy changes are affecting technology sector valuations and what investors should watch for in the coming quarters.",
      "duration": "28:45",
      "publishedAt": "2 hours ago",
      "datePublished": DateTime.now().subtract(Duration(hours: 2)),
      "season": 5,
      "episode": 15,
      "isPlayed": false,
      "isDownloaded": true,
      "isBookmarked": false,
      "playCount": 12400,
      "rating": 4.8,
      "image": "https://picsum.photos/200/200?random=11&keyword=fed-policy",
      "tags": ["Federal Reserve", "Tech Stocks", "Market Analysis"]
    },
    {
      "id": "ep014",
      "title": "Q4 Earnings Preview: Key Companies to Watch",
      "description": "A comprehensive look at the most important earnings reports coming this week and their potential market impact on major indices.",
      "duration": "32:12",
      "publishedAt": "1 day ago",
      "datePublished": DateTime.now().subtract(Duration(days: 1)),
      "season": 5,
      "episode": 14,
      "isPlayed": true,
      "isDownloaded": false,
      "isBookmarked": true,
      "playCount": 18700,
      "rating": 4.9,
      "image": "https://picsum.photos/200/200?random=12&keyword=earnings",
      "tags": ["Earnings", "Q4 Results", "Corporate Performance"]
    },
    {
      "id": "ep013",
      "title": "Cryptocurrency Market Analysis: Bitcoin ETF Impact",
      "description": "Deep dive into how the approval of Bitcoin ETFs is reshaping the cryptocurrency landscape and institutional adoption trends.",
      "duration": "25:30",
      "publishedAt": "2 days ago",
      "datePublished": DateTime.now().subtract(Duration(days: 2)),
      "season": 5,
      "episode": 13,
      "isPlayed": true,
      "isDownloaded": true,
      "isBookmarked": false,
      "playCount": 15600,
      "rating": 4.7,
      "image": "https://picsum.photos/200/200?random=13&keyword=bitcoin",
      "tags": ["Cryptocurrency", "Bitcoin", "ETF", "Institutional Investment"]
    },
    {
      "id": "ep012",
      "title": "Real Estate Investment Trusts: Market Outlook",
      "description": "Examining REIT performance in the current interest rate environment and opportunities for income-focused investors.",
      "duration": "29:18",
      "publishedAt": "3 days ago",
      "datePublished": DateTime.now().subtract(Duration(days: 3)),
      "season": 5,
      "episode": 12,
      "isPlayed": false,
      "isDownloaded": false,
      "isBookmarked": true,
      "playCount": 11200,
      "rating": 4.6,
      "image": "https://picsum.photos/200/200?random=14&keyword=real-estate",
      "tags": ["REIT", "Real Estate", "Income Investing", "Interest Rates"]
    },
    {
      "id": "ep011",
      "title": "Global Supply Chain Update: Economic Implications",
      "description": "Latest developments in global supply chains and their impact on inflation, corporate earnings, and consumer prices.",
      "duration": "26:45",
      "publishedAt": "4 days ago",
      "datePublished": DateTime.now().subtract(Duration(days: 4)),
      "season": 5,
      "episode": 11,
      "isPlayed": true,
      "isDownloaded": true,
      "isBookmarked": false,
      "playCount": 14300,
      "rating": 4.8,
      "image": "https://picsum.photos/200/200?random=15&keyword=supply-chain",
      "tags": ["Supply Chain", "Inflation", "Global Economics"]
    },
    {
      "id": "ep010",
      "title": "ESG Investing: Trends and Performance Analysis",
      "description": "Analyzing the latest trends in ESG investing and how sustainability factors are affecting investment returns and portfolio allocation.",
      "duration": "31:22",
      "publishedAt": "5 days ago",
      "datePublished": DateTime.now().subtract(Duration(days: 5)),
      "season": 5,
      "episode": 10,
      "isPlayed": false,
      "isDownloaded": false,
      "isBookmarked": false,
      "playCount": 9800,
      "rating": 4.5,
      "image": "https://picsum.photos/200/200?random=16&keyword=esg-investing",
      "tags": ["ESG", "Sustainability", "Investment Trends"]
    }
  ];

  List<Map<String, dynamic>> seasons = [
    {"label": "All Seasons", "value": "All Seasons"},
    {"label": "Season 5 (Current)", "value": "Season 5"},
    {"label": "Season 4", "value": "Season 4"},
    {"label": "Season 3", "value": "Season 3"},
    {"label": "Season 2", "value": "Season 2"},
    {"label": "Season 1", "value": "Season 1"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "Newest First"},
    {"label": "Oldest First", "value": "Oldest First"},
    {"label": "Most Popular", "value": "Most Popular"},
    {"label": "Highest Rated", "value": "Highest Rated"},
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Episodes", "value": "All Episodes"},
    {"label": "Unplayed", "value": "Unplayed"},
    {"label": "Downloaded", "value": "Downloaded"},
    {"label": "Bookmarked", "value": "Bookmarked"},
  ];

  List<Map<String, dynamic>> get filteredAndSortedEpisodes {
    var filtered = episodes.where((episode) {
      // Season filter
      if (selectedSeason != "All Seasons") {
        final seasonNumber = int.tryParse(selectedSeason.split(" ")[1]) ?? 5;
        if (episode["season"] != seasonNumber) return false;
      }

      // Additional filters
      switch (filterBy) {
        case "Unplayed":
          return !(episode["isPlayed"] as bool);
        case "Downloaded":
          return episode["isDownloaded"] as bool;
        case "Bookmarked":
          return episode["isBookmarked"] as bool;
        default:
          return true;
      }
    }).toList();

    // Sort episodes
    switch (sortBy) {
      case "Oldest First":
        filtered.sort((a, b) => (a["datePublished"] as DateTime).compareTo(b["datePublished"] as DateTime));
        break;
      case "Most Popular":
        filtered.sort((a, b) => (b["playCount"] as int).compareTo(a["playCount"] as int));
        break;
      case "Highest Rated":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      default: // Newest First
        filtered.sort((a, b) => (b["datePublished"] as DateTime).compareTo(a["datePublished"] as DateTime));
        break;
    }

    return filtered;
  }

  void _toggleBookmark(String episodeId) {
    final episodeIndex = episodes.indexWhere((episode) => episode["id"] == episodeId);
    if (episodeIndex != -1) {
      episodes[episodeIndex]["isBookmarked"] = !(episodes[episodeIndex]["isBookmarked"] as bool);
      setState(() {});
    }
  }

  void _markAsPlayed(String episodeId) {
    final episodeIndex = episodes.indexWhere((episode) => episode["id"] == episodeId);
    if (episodeIndex != -1) {
      episodes[episodeIndex]["isPlayed"] = true;
      setState(() {});
    }
  }

  void _downloadEpisode(String episodeId) {
    final episodeIndex = episodes.indexWhere((episode) => episode["id"] == episodeId);
    if (episodeIndex != -1) {
      episodes[episodeIndex]["isDownloaded"] = !(episodes[episodeIndex]["isDownloaded"] as bool);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredEpisodes = filteredAndSortedEpisodes;

    return Scaffold(
      appBar: AppBar(
        title: Text("Episodes"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Download all episodes
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
            // Podcast Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "https://picsum.photos/300/300?random=1&keyword=finance",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "The Daily Finance Report",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "by Sarah Mitchell",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "4.8",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "245 episodes",
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
                          label: "Season",
                          items: seasons,
                          value: selectedSeason,
                          onChanged: (value, label) {
                            selectedSeason = value;
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
                  QDropdownField(
                    label: "Filter",
                    items: filterOptions,
                    value: filterBy,
                    onChanged: (value, label) {
                      filterBy = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Episode Statistics
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
                        "${filteredEpisodes.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Episodes",
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
                        "${episodes.where((e) => !(e["isPlayed"] as bool)).length}",
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
                        "${episodes.where((e) => e["isDownloaded"] as bool).length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Downloaded",
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

            // Episodes List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Episodes",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${filteredEpisodes.length} episodes",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        // Play all episodes
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Play All",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Episodes Display
            if (isGridView) ...[
              // Grid View
              ResponsiveGridView(
                minItemWidth: 200,
                children: filteredEpisodes.map((episode) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Episode Image
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              child: Image.network(
                                "${episode["image"]}",
                                width: double.infinity,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            
                            // Status Indicators
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: Row(
                                children: [
                                  if (episode["isDownloaded"] as bool) ...[
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.download_done,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                  ],
                                  if (episode["isPlayed"] as bool) ...[
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            // Play Button Overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(100),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusMd),
                                    topRight: Radius.circular(radiusMd),
                                  ),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      _markAsPlayed("${episode["id"]}");
                                      // Play episode
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: primaryColor,
                                        size: 24,
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
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Episode Number and Duration
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "S${episode["season"]}E${episode["episode"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${episode["duration"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),

                              // Title
                              Text(
                                "${episode["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Description
                              Text(
                                "${episode["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Rating and Stats
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: warningColor,
                                        size: 12,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${(episode["rating"] as double).toStringAsFixed(1)}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${(episode["playCount"] as int).toString()} plays",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),

                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Play",
                                      size: bs.sm,
                                      onPressed: () {
                                        _markAsPlayed("${episode["id"]}");
                                        // Play episode
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  GestureDetector(
                                    onTap: () => _toggleBookmark("${episode["id"]}"),
                                    child: Icon(
                                      (episode["isBookmarked"] as bool) 
                                          ? Icons.bookmark 
                                          : Icons.bookmark_border,
                                      color: (episode["isBookmarked"] as bool) 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                      size: 20,
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
            ] else ...[
              // List View
              ...filteredEpisodes.map((episode) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      // Episode Image
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${episode["image"]}",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          // Play Button Overlay
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(100),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _markAsPlayed("${episode["id"]}");
                                    // Play episode
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spSm),

                      // Episode Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "S${episode["season"]}E${episode["episode"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    if (episode["isDownloaded"] as bool) ...[
                                      Icon(
                                        Icons.download_done,
                                        size: 16,
                                        color: successColor,
                                      ),
                                      SizedBox(width: 4),
                                    ],
                                    if (episode["isPlayed"] as bool) ...[
                                      Icon(
                                        Icons.check_circle,
                                        size: 16,
                                        color: primaryColor,
                                      ),
                                      SizedBox(width: 4),
                                    ],
                                    Text(
                                      "${episode["duration"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 4),
                            
                            Text(
                              "${episode["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            SizedBox(height: 4),
                            
                            Text(
                              "${episode["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: warningColor,
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${(episode["rating"] as double).toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${episode["publishedAt"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _downloadEpisode("${episode["id"]}"),
                                      child: Icon(
                                        (episode["isDownloaded"] as bool) 
                                            ? Icons.download_done 
                                            : Icons.download,
                                        color: (episode["isDownloaded"] as bool) 
                                            ? successColor 
                                            : disabledBoldColor,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    GestureDetector(
                                      onTap: () => _toggleBookmark("${episode["id"]}"),
                                      child: Icon(
                                        (episode["isBookmarked"] as bool) 
                                            ? Icons.bookmark 
                                            : Icons.bookmark_border,
                                        color: (episode["isBookmarked"] as bool) 
                                            ? primaryColor 
                                            : disabledBoldColor,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.more_vert,
                                      color: disabledBoldColor,
                                      size: 20,
                                    ),
                                  ],
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
            ],

            // Load More Button
            if (filteredEpisodes.isNotEmpty) ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Episodes",
                  size: bs.md,
                  onPressed: () {
                    // Load more episodes
                  },
                ),
              ),
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
                      "No episodes found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
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
