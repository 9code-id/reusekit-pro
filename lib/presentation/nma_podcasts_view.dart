import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaPodcastsView extends StatefulWidget {
  const NmaPodcastsView({super.key});

  @override
  State<NmaPodcastsView> createState() => _NmaPodcastsViewState();
}

class _NmaPodcastsViewState extends State<NmaPodcastsView> {
  String selectedCategory = "All";
  String selectedDuration = "All";
  String searchQuery = "";
  bool showSubscribedOnly = false;

  List<Map<String, dynamic>> podcasts = [
    {
      "id": "1",
      "title": "The Daily Finance Report",
      "host": "Sarah Mitchell",
      "description": "Daily insights into market movements, economic trends, and financial news that matters to your portfolio.",
      "image": "https://picsum.photos/300/300?random=1&keyword=finance",
      "category": "Finance",
      "subscriberCount": "125K",
      "episodeCount": 245,
      "avgDuration": "25 min",
      "rating": 4.8,
      "isSubscribed": true,
      "lastEpisode": "Fed Policy Impact on Tech Stocks",
      "lastEpisodeDate": "2 hours ago",
      "tags": ["Markets", "Economics", "Investment"]
    },
    {
      "id": "2",
      "title": "Startup Stories",
      "host": "Mike Chen & Lisa Rodriguez",
      "description": "Conversations with founders, VCs, and entrepreneurs about building successful companies in today's market.",
      "image": "https://picsum.photos/300/300?random=2&keyword=startup",
      "category": "Business",
      "subscriberCount": "89K",
      "episodeCount": 156,
      "avgDuration": "45 min",
      "rating": 4.6,
      "isSubscribed": false,
      "lastEpisode": "Scaling SaaS: From 0 to 100M ARR",
      "lastEpisodeDate": "1 day ago",
      "tags": ["Startups", "Entrepreneurship", "VC"]
    },
    {
      "id": "3",
      "title": "Crypto Weekly",
      "host": "Alex Thompson",
      "description": "Your weekly dose of cryptocurrency news, analysis, and market predictions from industry experts.",
      "image": "https://picsum.photos/300/300?random=3&keyword=crypto",
      "category": "Cryptocurrency",
      "subscriberCount": "67K",
      "episodeCount": 98,
      "avgDuration": "35 min",
      "rating": 4.5,
      "isSubscribed": true,
      "lastEpisode": "Bitcoin ETF Impact Analysis",
      "lastEpisodeDate": "3 days ago",
      "tags": ["Bitcoin", "DeFi", "Blockchain"]
    },
    {
      "id": "4",
      "title": "Tech Talk Today",
      "host": "Emma Wilson",
      "description": "Latest technology trends, product launches, and industry analysis from Silicon Valley and beyond.",
      "image": "https://picsum.photos/300/300?random=4&keyword=technology",
      "category": "Technology",
      "subscriberCount": "156K",
      "episodeCount": 312,
      "avgDuration": "30 min",
      "rating": 4.9,
      "isSubscribed": false,
      "lastEpisode": "AI Revolution in Healthcare",
      "lastEpisodeDate": "12 hours ago",
      "tags": ["AI", "Innovation", "Silicon Valley"]
    },
    {
      "id": "5",
      "title": "Global Economics Hour",
      "host": "Dr. James Park",
      "description": "In-depth analysis of global economic trends, policy changes, and their impact on international markets.",
      "image": "https://picsum.photos/300/300?random=5&keyword=economics",
      "category": "Economics",
      "subscriberCount": "45K",
      "episodeCount": 87,
      "avgDuration": "50 min",
      "rating": 4.7,
      "isSubscribed": true,
      "lastEpisode": "Trade Wars and Supply Chains",
      "lastEpisodeDate": "2 days ago",
      "tags": ["Global Trade", "Policy", "Macroeconomics"]
    },
    {
      "id": "6",
      "title": "Real Estate Insights",
      "host": "Jennifer Adams",
      "description": "Real estate market analysis, investment strategies, and property trends across different markets.",
      "image": "https://picsum.photos/300/300?random=6&keyword=realestate",
      "category": "Real Estate",
      "subscriberCount": "32K",
      "episodeCount": 124,
      "avgDuration": "28 min",
      "rating": 4.4,
      "isSubscribed": false,
      "lastEpisode": "Commercial Real Estate Outlook 2024",
      "lastEpisodeDate": "1 week ago",
      "tags": ["Property", "Investment", "Market Trends"]
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Business", "value": "Business"},
    {"label": "Cryptocurrency", "value": "Cryptocurrency"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Economics", "value": "Economics"},
    {"label": "Real Estate", "value": "Real Estate"},
  ];

  List<Map<String, dynamic>> durations = [
    {"label": "All", "value": "All"},
    {"label": "Short (< 30 min)", "value": "Short"},
    {"label": "Medium (30-45 min)", "value": "Medium"},
    {"label": "Long (> 45 min)", "value": "Long"},
  ];

  List<Map<String, dynamic>> get filteredPodcasts {
    return podcasts.where((podcast) {
      final matchesCategory = selectedCategory == "All" || podcast["category"] == selectedCategory;
      final matchesSubscription = !showSubscribedOnly || (podcast["isSubscribed"] as bool);
      final matchesSearch = searchQuery.isEmpty || 
          podcast["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          podcast["host"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          podcast["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDuration = true;
      if (selectedDuration != "All") {
        final avgDurationStr = podcast["avgDuration"] as String;
        final duration = int.tryParse(avgDurationStr.split(" ")[0]) ?? 0;
        switch (selectedDuration) {
          case "Short":
            matchesDuration = duration < 30;
            break;
          case "Medium":
            matchesDuration = duration >= 30 && duration <= 45;
            break;
          case "Long":
            matchesDuration = duration > 45;
            break;
        }
      }
      
      return matchesCategory && matchesSubscription && matchesSearch && matchesDuration;
    }).toList();
  }

  void _toggleSubscription(String podcastId) {
    final podcastIndex = podcasts.indexWhere((podcast) => podcast["id"] == podcastId);
    if (podcastIndex != -1) {
      podcasts[podcastIndex]["isSubscribed"] = !(podcasts[podcastIndex]["isSubscribed"] as bool);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Podcasts"),
        actions: [
          IconButton(
            icon: Icon(showSubscribedOnly ? Icons.subscriptions : Icons.subscriptions_outlined),
            onPressed: () {
              showSubscribedOnly = !showSubscribedOnly;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Open search
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
            // Search Bar
            QTextField(
              label: "Search podcasts...",
              value: searchQuery,
              hint: "Search by title, host, or description",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
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
                    "Filters",
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
                          label: "Duration",
                          items: durations,
                          value: selectedDuration,
                          onChanged: (value, label) {
                            selectedDuration = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
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
                        "${filteredPodcasts.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Available",
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
                        "${podcasts.where((p) => p["isSubscribed"] as bool).length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Subscribed",
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
                        "${podcasts.map((p) => p["episodeCount"] as int).reduce((a, b) => a + b)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Total Episodes",
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

            // Featured Podcasts Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  showSubscribedOnly ? "My Subscriptions" : "Discover Podcasts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${filteredPodcasts.length} podcasts",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            // Podcasts List
            if (filteredPodcasts.isNotEmpty) ...[
              ...filteredPodcasts.map((podcast) {
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
                              child: Image.network(
                                "${podcast["image"]}",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
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
                                          "${podcast["category"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _toggleSubscription("${podcast["id"]}"),
                                        child: Icon(
                                          (podcast["isSubscribed"] as bool) 
                                              ? Icons.notifications 
                                              : Icons.notifications_none,
                                          color: (podcast["isSubscribed"] as bool) 
                                              ? primaryColor 
                                              : disabledBoldColor,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: spXs),

                                  Text(
                                    "${podcast["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  SizedBox(height: 4),

                                  Text(
                                    "by ${podcast["host"]}",
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
                                        "${(podcast["rating"] as double).toStringAsFixed(1)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${podcast["subscriberCount"]} subscribers",
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

                      // Description
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Text(
                          "${podcast["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Tags
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (podcast["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                "$tag",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Stats Row
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Latest Episode",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                                Text(
                                  "${podcast["lastEpisode"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${podcast["lastEpisodeDate"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${podcast["episodeCount"]} episodes",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Avg ${podcast["avgDuration"]}",
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

                      SizedBox(height: spSm),

                      // Action Buttons
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: (podcast["isSubscribed"] as bool) ? "View Episodes" : "Subscribe",
                                size: bs.sm,
                                onPressed: () {
                                  if (podcast["isSubscribed"] as bool) {
                                    // Navigate to episodes
                                  } else {
                                    _toggleSubscription("${podcast["id"]}");
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () {
                                // Share podcast
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.share,
                                  size: 20,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            GestureDetector(
                              onTap: () {
                                // More options
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.more_vert,
                                  size: 20,
                                  color: disabledBoldColor,
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
                      "No podcasts found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      showSubscribedOnly 
                          ? "You haven't subscribed to any podcasts yet"
                          : "Try adjusting your filters or search terms",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],

            // Load More Button
            if (filteredPodcasts.isNotEmpty) ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Discover More Podcasts",
                  size: bs.md,
                  onPressed: () {
                    // Load more podcasts
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
