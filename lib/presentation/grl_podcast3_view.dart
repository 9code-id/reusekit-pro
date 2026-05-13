import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPodcast3View extends StatefulWidget {
  @override
  State<GrlPodcast3View> createState() => _GrlPodcast3ViewState();
}

class _GrlPodcast3ViewState extends State<GrlPodcast3View> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedGenre = "All Genres";
  bool isSubscribed = false;
  bool notificationsEnabled = true;
  bool autoDownload = false;
  double playbackSpeed = 1.0;
  String selectedQuality = "High";
  
  List<Map<String, dynamic>> podcastLibrary = [
    {
      "id": 1,
      "title": "The Daily Tech",
      "host": "Sarah Johnson",
      "image": "https://picsum.photos/150/150?random=1&keyword=tech",
      "category": "Technology",
      "isSubscribed": true,
      "totalEpisodes": 125,
      "unplayedCount": 3,
      "lastUpdated": "2 hours ago",
      "rating": 4.8,
      "description": "Daily insights into the latest technology trends and innovations.",
      "downloadedEpisodes": 5,
      "totalSize": "245 MB"
    },
    {
      "id": 2,
      "title": "Business Insider",
      "host": "Michael Chen",
      "image": "https://picsum.photos/150/150?random=2&keyword=business",
      "category": "Business",
      "isSubscribed": true,
      "totalEpisodes": 89,
      "unplayedCount": 1,
      "lastUpdated": "1 day ago",
      "rating": 4.6,
      "description": "Expert analysis on business trends and market insights.",
      "downloadedEpisodes": 3,
      "totalSize": "178 MB"
    },
    {
      "id": 3,
      "title": "Health & Wellness",
      "host": "Dr. Emily Rodriguez",
      "image": "https://picsum.photos/150/150?random=3&keyword=health",
      "category": "Health",
      "isSubscribed": false,
      "totalEpisodes": 67,
      "unplayedCount": 0,
      "lastUpdated": "3 days ago",
      "rating": 4.9,
      "description": "Evidence-based health advice and wellness tips.",
      "downloadedEpisodes": 0,
      "totalSize": "0 MB"
    },
    {
      "id": 4,
      "title": "Comedy Hour",
      "host": "Jake Williams",
      "image": "https://picsum.photos/150/150?random=4&keyword=comedy",
      "category": "Comedy",
      "isSubscribed": true,
      "totalEpisodes": 234,
      "unplayedCount": 8,
      "lastUpdated": "5 hours ago",
      "rating": 4.4,
      "description": "Hilarious comedy sketches and stand-up performances.",
      "downloadedEpisodes": 12,
      "totalSize": "567 MB"
    },
    {
      "id": 5,
      "title": "Science Explained",
      "host": "Prof. David Kim",
      "image": "https://picsum.photos/150/150?random=5&keyword=science",
      "category": "Science",
      "isSubscribed": true,
      "totalEpisodes": 156,
      "unplayedCount": 2,
      "lastUpdated": "1 day ago",
      "rating": 4.7,
      "description": "Complex scientific concepts made simple and accessible.",
      "downloadedEpisodes": 7,
      "totalSize": "334 MB"
    },
    {
      "id": 6,
      "title": "Sports Talk",
      "host": "Alex Thompson",
      "image": "https://picsum.photos/150/150?random=6&keyword=sports",
      "category": "Sports",
      "isSubscribed": false,
      "totalEpisodes": 198,
      "unplayedCount": 0,
      "lastUpdated": "2 days ago",
      "rating": 4.3,
      "description": "Latest sports news, analysis, and athlete interviews.",
      "downloadedEpisodes": 0,
      "totalSize": "0 MB"
    }
  ];

  List<Map<String, dynamic>> recentEpisodes = [
    {
      "id": 1,
      "title": "AI Revolution in 2025",
      "podcast": "The Daily Tech",
      "duration": "45:23",
      "publishedDate": "Today",
      "isPlayed": false,
      "isDownloaded": true,
      "progress": 0.0,
      "description": "Exploring the latest AI developments and their impact on society."
    },
    {
      "id": 2,
      "title": "Market Analysis Q1 2025",
      "podcast": "Business Insider",
      "duration": "38:15",
      "publishedDate": "Yesterday",
      "isPlayed": true,
      "isDownloaded": false,
      "progress": 1.0,
      "description": "Comprehensive analysis of first quarter market performance."
    },
    {
      "id": 3,
      "title": "Mental Health in Digital Age",
      "podcast": "Health & Wellness",
      "duration": "52:41",
      "publishedDate": "2 days ago",
      "isPlayed": false,
      "isDownloaded": true,
      "progress": 0.35,
      "description": "How technology affects our mental health and coping strategies."
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Business", "value": "Business"},
    {"label": "Health", "value": "Health"},
    {"label": "Comedy", "value": "Comedy"},
    {"label": "Science", "value": "Science"},
    {"label": "Sports", "value": "Sports"}
  ];

  List<Map<String, dynamic>> genres = [
    {"label": "All Genres", "value": "All Genres"},
    {"label": "Education", "value": "Education"},
    {"label": "Entertainment", "value": "Entertainment"},
    {"label": "News", "value": "News"},
    {"label": "Interview", "value": "Interview"}
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "High (320kbps)", "value": "High"},
    {"label": "Medium (128kbps)", "value": "Medium"},
    {"label": "Low (64kbps)", "value": "Low"}
  ];

  List<Map<String, dynamic>> playbackSpeedOptions = [
    {"label": "0.5x", "value": 0.5},
    {"label": "0.75x", "value": 0.75},
    {"label": "1x", "value": 1.0},
    {"label": "1.25x", "value": 1.25},
    {"label": "1.5x", "value": 1.5},
    {"label": "2x", "value": 2.0}
  ];

  List<Map<String, dynamic>> get filteredPodcasts {
    return podcastLibrary.where((podcast) {
      bool matchesSearch = searchQuery.isEmpty || 
          "${podcast["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${podcast["host"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || 
          podcast["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _toggleSubscription(int podcastId) {
    setState(() {
      int index = podcastLibrary.indexWhere((p) => p["id"] == podcastId);
      if (index != -1) {
        podcastLibrary[index]["isSubscribed"] = !podcastLibrary[index]["isSubscribed"];
        String action = podcastLibrary[index]["isSubscribed"] ? "subscribed to" : "unsubscribed from";
        ss("Successfully $action ${podcastLibrary[index]["title"]}");
      }
    });
  }

  void _downloadEpisode(int episodeId) {
    setState(() {
      int index = recentEpisodes.indexWhere((e) => e["id"] == episodeId);
      if (index != -1) {
        recentEpisodes[index]["isDownloaded"] = !recentEpisodes[index]["isDownloaded"];
        String action = recentEpisodes[index]["isDownloaded"] ? "downloaded" : "removed";
        ss("Episode $action successfully");
      }
    });
  }

  void _playEpisode(int episodeId) {
    int index = recentEpisodes.indexWhere((e) => e["id"] == episodeId);
    if (index != -1) {
      ss("Playing ${recentEpisodes[index]["title"]}");
    }
  }

  Widget _buildLibraryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filter
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search podcasts...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  _showFilterDialog();
                },
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Category Filter
          QCategoryPicker(
            items: categories,
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),

          SizedBox(height: spMd),

          // Subscribed Podcasts Section
          Text(
            "My Subscriptions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ...filteredPodcasts.where((podcast) => podcast["isSubscribed"]).map((podcast) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${podcast["image"]}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${podcast["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "By ${podcast["host"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: (podcast["unplayedCount"] as int) > 0 ? warningColor : disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${podcast["unplayedCount"]} new",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Icon(Icons.download, size: 16, color: disabledBoldColor),
                            SizedBox(width: 4),
                            Text(
                              "${podcast["downloadedEpisodes"]}/${podcast["totalEpisodes"]}",
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
                  Column(
                    children: [
                      QButton(
                        icon: Icons.play_arrow,
                        size: bs.sm,
                        onPressed: () {
                          ss("Playing latest episode from ${podcast["title"]}");
                        },
                      ),
                      SizedBox(height: spXs),
                      GestureDetector(
                        onTap: () => _toggleSubscription(podcast["id"]),
                        child: Icon(
                          Icons.unsubscribe,
                          color: dangerColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),

          SizedBox(height: spMd),

          // Discover More Section
          Text(
            "Discover More",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ...filteredPodcasts.where((podcast) => !podcast["isSubscribed"]).map((podcast) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${podcast["image"]}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${podcast["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "By ${podcast["host"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: warningColor),
                            SizedBox(width: 4),
                            Text(
                              "${podcast["rating"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${podcast["totalEpisodes"]} episodes",
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
                  QButton(
                    label: "Subscribe",
                    size: bs.sm,
                    onPressed: () => _toggleSubscription(podcast["id"]),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildEpisodesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Episodes Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Episodes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  ss("Marking all episodes as played");
                },
                child: Text(
                  "Mark all played",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Episodes List
          ...recentEpisodes.map((episode) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: !(episode["isPlayed"] as bool) ? primaryColor : disabledColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${episode["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${episode["podcast"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _downloadEpisode(episode["id"]),
                            child: Icon(
                              episode["isDownloaded"] ? Icons.download_done : Icons.download,
                              color: episode["isDownloaded"] ? successColor : disabledBoldColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.play_arrow,
                            size: bs.sm,
                            onPressed: () => _playEpisode(episode["id"]),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  // Progress Bar
                  if ((episode["progress"] as double) > 0)
                    Column(
                      children: [
                        LinearProgressIndicator(
                          value: episode["progress"] as double,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                        SizedBox(height: spXs),
                      ],
                    ),

                  // Episode Info
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${episode["duration"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${episode["publishedDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      if (episode["isDownloaded"])
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Downloaded",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  Text(
                    "${episode["description"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDownloadsTab() {
    List<Map<String, dynamic>> downloadedEpisodes = recentEpisodes
        .where((episode) => episode["isDownloaded"])
        .toList();

    double totalSize = podcastLibrary
        .fold(0.0, (sum, podcast) => sum + double.parse((podcast["totalSize"] as String).replaceAll(" MB", "")));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Storage Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Storage Usage",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Downloaded Episodes",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${downloadedEpisodes.length} episodes",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Total Size",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${totalSize.toStringAsFixed(0)} MB",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Clean Up",
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Remove all downloaded episodes?");
                          if (isConfirmed) {
                            setState(() {
                              for (var episode in recentEpisodes) {
                                episode["isDownloaded"] = false;
                              }
                            });
                            ss("All downloads removed successfully");
                          }
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Settings",
                        size: bs.sm,
                        onPressed: () {
                          _showDownloadSettings();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Downloaded Episodes
          if (downloadedEpisodes.isNotEmpty) ...[
            Text(
              "Downloaded Episodes",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...downloadedEpisodes.map((episode) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.download_done,
                      color: successColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${episode["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${episode["podcast"]} • ${episode["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        QButton(
                          icon: Icons.play_arrow,
                          size: bs.sm,
                          onPressed: () => _playEpisode(episode["id"]),
                        ),
                        SizedBox(width: spXs),
                        GestureDetector(
                          onTap: () => _downloadEpisode(episode["id"]),
                          child: Icon(
                            Icons.delete,
                            color: dangerColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ] else ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.download_outlined,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No Downloaded Episodes",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Download episodes to listen offline",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Playback Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Playback Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),

                QDropdownField(
                  label: "Default Playback Speed",
                  items: playbackSpeedOptions,
                  value: playbackSpeed,
                  onChanged: (value, label) {
                    playbackSpeed = value;
                    setState(() {});
                  },
                ),

                SizedBox(height: spSm),

                QDropdownField(
                  label: "Audio Quality",
                  items: qualityOptions,
                  value: selectedQuality,
                  onChanged: (value, label) {
                    selectedQuality = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Download Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Download Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),

                QSwitch(
                  items: [
                    {
                      "label": "Auto-download new episodes",
                      "value": true,
                      "checked": autoDownload,
                    }
                  ],
                  value: [
                    if (autoDownload)
                      {
                        "label": "Auto-download new episodes",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    autoDownload = values.isNotEmpty;
                    setState(() {});
                  },
                ),

                SizedBox(height: spSm),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Download Queue",
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening download queue");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Manage Storage",
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening storage management");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Notification Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),

                QSwitch(
                  items: [
                    {
                      "label": "New episode notifications",
                      "value": true,
                      "checked": notificationsEnabled,
                    }
                  ],
                  value: [
                    if (notificationsEnabled)
                      {
                        "label": "New episode notifications",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    notificationsEnabled = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Account Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account & Sync",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Sync Subscriptions",
                        size: bs.sm,
                        onPressed: () {
                          ss("Syncing subscriptions...");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Export Data",
                        size: bs.sm,
                        onPressed: () {
                          ss("Exporting podcast data...");
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Import OPML",
                    size: bs.sm,
                    onPressed: () {
                      ss("Import OPML file to add subscriptions");
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // About Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "App Version",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "2.1.0",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Help & Support",
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening help center");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Rate App",
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening app store for rating");
                        },
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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Podcasts"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Genre",
              items: genres,
              value: selectedGenre,
              onChanged: (value, label) {
                selectedGenre = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Filters applied");
            },
          ),
        ],
      ),
    );
  }

  void _showDownloadSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Download Settings"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Download Quality",
              items: qualityOptions,
              value: selectedQuality,
              onChanged: (value, label) {
                selectedQuality = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QSwitch(
              items: [
                {
                  "label": "WiFi only downloads",
                  "value": true,
                  "checked": true,
                }
              ],
              value: [
                {
                  "label": "WiFi only downloads",
                  "value": true,
                  "checked": true
                }
              ],
              onChanged: (values, ids) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Download settings saved");
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "My Podcasts",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Library", icon: Icon(Icons.library_music)),
        Tab(text: "Episodes", icon: Icon(Icons.queue_music)),
        Tab(text: "Downloads", icon: Icon(Icons.download)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildLibraryTab(),
        _buildEpisodesTab(),
        _buildDownloadsTab(),
        _buildSettingsTab(),
      ],
    );
  }
}
