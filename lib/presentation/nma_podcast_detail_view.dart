import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaPodcastDetailView extends StatefulWidget {
  const NmaPodcastDetailView({super.key});

  @override
  State<NmaPodcastDetailView> createState() => _NmaPodcastDetailViewState();
}

class _NmaPodcastDetailViewState extends State<NmaPodcastDetailView> {
  bool isSubscribed = true;
  bool isPlaying = false;
  double playbackSpeed = 1.0;
  String selectedSeason = "All Seasons";

  Map<String, dynamic> podcastInfo = {
    "id": "1",
    "title": "The Daily Finance Report",
    "host": "Sarah Mitchell",
    "description": "Daily insights into market movements, economic trends, and financial news that matters to your portfolio. Join Sarah Mitchell as she breaks down complex financial concepts into digestible insights for investors at all levels.",
    "longDescription": "The Daily Finance Report has been your trusted source for financial news and analysis since 2019. With over 125,000 subscribers worldwide, Sarah Mitchell brings her 15 years of Wall Street experience to help you navigate the complex world of finance. Each episode covers market movements, economic indicators, investment strategies, and breaking financial news that could impact your portfolio.\n\nWhether you're a seasoned investor or just starting your financial journey, The Daily Finance Report provides actionable insights that help you make informed decisions. From understanding Fed policy changes to analyzing earnings reports, Sarah breaks down complex topics into clear, actionable advice.",
    "image": "https://picsum.photos/400/400?random=1&keyword=finance",
    "bannerImage": "https://picsum.photos/800/300?random=1&keyword=finance-studio",
    "category": "Finance",
    "subscriberCount": "125K",
    "episodeCount": 245,
    "avgDuration": "25 min",
    "rating": 4.8,
    "totalRatings": 3420,
    "publisher": "Finance Media Network",
    "language": "English",
    "country": "United States",
    "frequency": "Daily",
    "startDate": "January 2019",
    "website": "www.dailyfinancereport.com",
    "tags": ["Markets", "Economics", "Investment", "Business News", "Personal Finance"]
  };

  List<Map<String, dynamic>> episodes = [
    {
      "id": "ep001",
      "title": "Fed Policy Impact on Tech Stocks",
      "description": "Analyzing how the Federal Reserve's latest policy changes are affecting technology sector valuations and what investors should watch for.",
      "duration": "28:45",
      "publishedAt": "2 hours ago",
      "season": 5,
      "episode": 15,
      "isPlayed": false,
      "isDownloaded": true,
      "playCount": 12400,
      "image": "https://picsum.photos/200/200?random=11&keyword=fed-policy"
    },
    {
      "id": "ep002",
      "title": "Q4 Earnings Preview: Key Companies to Watch",
      "description": "A comprehensive look at the most important earnings reports coming this week and their potential market impact.",
      "duration": "32:12",
      "publishedAt": "1 day ago",
      "season": 5,
      "episode": 14,
      "isPlayed": true,
      "isDownloaded": false,
      "playCount": 18700,
      "image": "https://picsum.photos/200/200?random=12&keyword=earnings"
    },
    {
      "id": "ep003",
      "title": "Cryptocurrency Market Analysis: Bitcoin ETF Impact",
      "description": "Deep dive into how the approval of Bitcoin ETFs is reshaping the cryptocurrency landscape and institutional adoption.",
      "duration": "25:30",
      "publishedAt": "2 days ago",
      "season": 5,
      "episode": 13,
      "isPlayed": true,
      "isDownloaded": true,
      "playCount": 15600,
      "image": "https://picsum.photos/200/200?random=13&keyword=bitcoin"
    },
    {
      "id": "ep004",
      "title": "Real Estate Investment Trusts: Market Outlook",
      "description": "Examining REIT performance in the current interest rate environment and opportunities for investors.",
      "duration": "29:18",
      "publishedAt": "3 days ago",
      "season": 5,
      "episode": 12,
      "isPlayed": false,
      "isDownloaded": false,
      "playCount": 11200,
      "image": "https://picsum.photos/200/200?random=14&keyword=real-estate"
    },
    {
      "id": "ep005",
      "title": "Global Supply Chain Update: Economic Implications",
      "description": "Latest developments in global supply chains and their impact on inflation and corporate earnings.",
      "duration": "26:45",
      "publishedAt": "4 days ago",
      "season": 5,
      "episode": 11,
      "isPlayed": true,
      "isDownloaded": true,
      "playCount": 14300,
      "image": "https://picsum.photos/200/200?random=15&keyword=supply-chain"
    },
    {
      "id": "ep006",
      "title": "ESG Investing: Trends and Performance Analysis",
      "description": "Analyzing the latest trends in ESG investing and how sustainability factors are affecting investment returns.",
      "duration": "31:22",
      "publishedAt": "5 days ago",
      "season": 5,
      "episode": 10,
      "isPlayed": false,
      "isDownloaded": false,
      "playCount": 9800,
      "image": "https://picsum.photos/200/200?random=16&keyword=esg-investing"
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

  List<Map<String, dynamic>> get filteredEpisodes {
    if (selectedSeason == "All Seasons") return episodes;
    final seasonNumber = int.tryParse(selectedSeason.split(" ")[1]) ?? 5;
    return episodes.where((episode) => episode["season"] == seasonNumber).toList();
  }

  void _toggleSubscription() {
    isSubscribed = !isSubscribed;
    setState(() {});
  }

  void _togglePlayback() {
    isPlaying = !isPlaying;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${podcastInfo["bannerImage"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withAlpha(100),
                          Colors.black.withAlpha(200),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // App Bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => back(),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.share, color: Colors.white),
                        onPressed: () {
                          // Share podcast
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {
                          // More options
                        },
                      ),
                    ],
                  ),
                ),

                // Podcast Info
                Positioned(
                  bottom: spMd,
                  left: spMd,
                  right: spMd,
                  child: Row(
                    children: [
                      // Podcast Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Image.network(
                          "${podcastInfo["image"]}",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),

                      // Basic Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${podcastInfo["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${podcastInfo["title"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "by ${podcastInfo["host"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
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
                                  "${(podcastInfo["rating"] as double).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${podcastInfo["subscriberCount"]} subscribers",
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
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: QButton(
                          label: isSubscribed ? "Subscribed" : "Subscribe",
                          size: bs.md,
                          onPressed: _toggleSubscription,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: IconButton(
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: primaryColor,
                            ),
                            onPressed: _togglePlayback,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledBoldColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.download,
                            color: disabledBoldColor,
                          ),
                          onPressed: () {
                            // Download episodes
                          },
                        ),
                      ),
                    ],
                  ),

                  // Stats Row
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${podcastInfo["episodeCount"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Episodes",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: Colors.grey.shade300,
                        ),
                        Column(
                          children: [
                            Text(
                              "${podcastInfo["avgDuration"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Avg Duration",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: Colors.grey.shade300,
                        ),
                        Column(
                          children: [
                            Text(
                              "${podcastInfo["frequency"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Updates",
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

                  // Description
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
                          "About This Podcast",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${podcastInfo["longDescription"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                        
                        // Tags
                        SizedBox(height: spSm),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (podcastInfo["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$tag",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        // Additional Info
                        SizedBox(height: spSm),
                        Column(
                          spacing: 4,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Publisher:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${podcastInfo["publisher"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Language:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${podcastInfo["language"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Started:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${podcastInfo["startDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Episodes Section
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
                            Text(
                              "${filteredEpisodes.length} episodes",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),

                        // Season Filter
                        QDropdownField(
                          label: "Season",
                          items: seasons,
                          value: selectedSeason,
                          onChanged: (value, label) {
                            selectedSeason = value;
                            setState(() {});
                          },
                        ),

                        // Episodes List
                        ...filteredEpisodes.map((episode) {
                          return Container(
                            margin: EdgeInsets.only(top: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                // Episode Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  child: Image.network(
                                    "${episode["image"]}",
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
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
                                              fontSize: 10,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              if (episode["isDownloaded"] as bool) ...[
                                                Icon(
                                                  Icons.download_done,
                                                  size: 14,
                                                  color: successColor,
                                                ),
                                                SizedBox(width: 4),
                                              ],
                                              if (episode["isPlayed"] as bool) ...[
                                                Icon(
                                                  Icons.check_circle,
                                                  size: 14,
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      
                                      SizedBox(height: 4),
                                      
                                      Text(
                                        "${episode["description"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      
                                      SizedBox(height: spXs),
                                      
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${episode["publishedAt"]}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: disabledColor,
                                            ),
                                          ),
                                          Text(
                                            "${episode["playCount"]} plays",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: spSm),

                                // Play Button
                                GestureDetector(
                                  onTap: () {
                                    // Play episode
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),

                        // Load More Episodes
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Load More Episodes",
                            size: bs.sm,
                            onPressed: () {
                              // Load more episodes
                            },
                          ),
                        ),
                      ],
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
}
