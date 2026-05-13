import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlaylist10View extends StatefulWidget {
  @override
  State<GrlPlaylist10View> createState() => _GrlPlaylist10ViewState();
}

class _GrlPlaylist10ViewState extends State<GrlPlaylist10View> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedMood = "All";
  
  List<String> moods = ["All", "Energetic", "Relaxing", "Focus", "Happy", "Romantic", "Sad"];
  
  List<Map<String, dynamic>> featuredPlaylists = [
    {
      "title": "Monday Motivation",
      "description": "Start your week with energy",
      "cover": "https://picsum.photos/160/160?random=1&keyword=motivation",
      "trackCount": 25,
      "duration": "1h 30m",
      "mood": "Energetic",
      "curator": "Music Team",
      "followers": 125000,
      "isOfficial": true,
    },
    {
      "title": "Coffee Shop Vibes",
      "description": "Perfect for work and study",
      "cover": "https://picsum.photos/160/160?random=2&keyword=coffee",
      "trackCount": 40,
      "duration": "2h 45m",
      "mood": "Relaxing",
      "curator": "Café Music",
      "followers": 89000,
      "isOfficial": false,
    },
    {
      "title": "Deep Focus",
      "description": "Instrumental music for concentration",
      "cover": "https://picsum.photos/160/160?random=3&keyword=focus",
      "trackCount": 35,
      "duration": "2h 15m",
      "mood": "Focus",
      "curator": "Study Helper",
      "followers": 67000,
      "isOfficial": true,
    },
  ];
  
  List<Map<String, dynamic>> topCharts = [
    {
      "rank": 1,
      "title": "Global Top 50",
      "description": "Most played songs worldwide",
      "cover": "https://picsum.photos/80/80?random=4&keyword=global",
      "trackCount": 50,
      "totalStreams": 2500000000,
      "changeFromLastWeek": 0,
    },
    {
      "rank": 2,
      "title": "Viral 50",
      "description": "Trending tracks right now",
      "cover": "https://picsum.photos/80/80?random=5&keyword=viral",
      "trackCount": 50,
      "totalStreams": 1800000000,
      "changeFromLastWeek": 1,
    },
    {
      "rank": 3,
      "title": "New Music Friday",
      "description": "Fresh releases this week",
      "cover": "https://picsum.photos/80/80?random=6&keyword=new",
      "trackCount": 30,
      "totalStreams": 950000000,
      "changeFromLastWeek": -1,
    },
  ];
  
  List<Map<String, dynamic>> newReleases = [
    {
      "title": "Electric Dreams",
      "artist": "Neon Pulse",
      "album": "Synth Wave",
      "cover": "https://picsum.photos/100/100?random=7&keyword=electric",
      "releaseDate": "2024-03-20",
      "genre": "Electronic",
      "trackCount": 12,
      "duration": "45m",
      "isNewArtist": false,
    },
    {
      "title": "Midnight Sessions",
      "artist": "Luna & The Stars",
      "album": "After Dark",
      "cover": "https://picsum.photos/100/100?random=8&keyword=midnight",
      "releaseDate": "2024-03-18",
      "genre": "Indie Pop",
      "trackCount": 8,
      "duration": "32m",
      "isNewArtist": true,
    },
    {
      "title": "Urban Stories",
      "artist": "City Beats",
      "album": "Street Tales",
      "cover": "https://picsum.photos/100/100?random=9&keyword=urban",
      "releaseDate": "2024-03-15",
      "genre": "Hip Hop",
      "trackCount": 15,
      "duration": "58m",
      "isNewArtist": false,
    },
  ];

  List<Map<String, dynamic>> get filteredFeaturedPlaylists {
    if (selectedMood == "All") return featuredPlaylists;
    return featuredPlaylists.where((playlist) => playlist["mood"] == selectedMood).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Browse Music",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Featured", icon: Icon(Icons.star)),
        Tab(text: "Charts", icon: Icon(Icons.trending_up)),
        Tab(text: "New Releases", icon: Icon(Icons.new_releases)),
      ],
      tabChildren: [
        _buildFeaturedTab(),
        _buildChartsTab(),
        _buildNewReleasesTab(),
      ],
    );
  }
  
  Widget _buildFeaturedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 20,
                  top: 20,
                  child: Icon(
                    Icons.music_note,
                    size: 80,
                    color: Colors.white.withAlpha(100),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Discover Amazing",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Playlists",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Curated collections for every mood and moment",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Explore Now",
                        color: Colors.white,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Search & Filter
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search playlists...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Mood Filter
          Text(
            "Filter by Mood",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spSm),
          
          QCategoryPicker(
            items: moods.map((mood) => {
              "label": mood,
              "value": mood,
            }).toList(),
            value: selectedMood,
            onChanged: (index, label, value, item) {
              selectedMood = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Featured Playlists
          Text(
            "Featured Playlists",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: filteredFeaturedPlaylists.map((playlist) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cover Image
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                        image: DecorationImage(
                          image: NetworkImage("${playlist["cover"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          if (playlist["isOfficial"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Official",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Content
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${playlist["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${playlist["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${playlist["mood"]}",
                                style: TextStyle(
                                  color: infoColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.queue_music,
                                  size: 12,
                                  color: disabledColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${playlist["trackCount"]} songs",
                                  style: TextStyle(
                                    color: disabledColor,
                                    fontSize: 11,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.access_time,
                                  size: 12,
                                  color: disabledColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${playlist["duration"]}",
                                  style: TextStyle(
                                    color: disabledColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "by ${playlist["curator"]}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${((playlist["followers"] as int) / 1000).toStringAsFixed(0)}K followers",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildChartsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Charts Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [warningColor, warningColor.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Music Charts",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "See what's trending worldwide",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Top Charts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Top Charts
          Column(
            spacing: spSm,
            children: topCharts.map((chart) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    // Rank
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (chart["rank"] as int) == 1 ? warningColor : primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "${chart["rank"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(width: spMd),
                    
                    // Cover
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusXs),
                        image: DecorationImage(
                          image: NetworkImage("${chart["cover"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    SizedBox(width: spMd),
                    
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${chart["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${chart["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${chart["trackCount"]} tracks • ${((chart["totalStreams"] as int) / 1000000000).toStringAsFixed(1)}B streams",
                            style: TextStyle(
                              color: disabledColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Movement
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (chart["changeFromLastWeek"] as int) > 0 ? successColor.withAlpha(30) :
                                   (chart["changeFromLastWeek"] as int) < 0 ? dangerColor.withAlpha(30) :
                                   disabledColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                (chart["changeFromLastWeek"] as int) > 0 ? Icons.arrow_upward :
                                (chart["changeFromLastWeek"] as int) < 0 ? Icons.arrow_downward :
                                Icons.remove,
                                size: 12,
                                color: (chart["changeFromLastWeek"] as int) > 0 ? successColor :
                                       (chart["changeFromLastWeek"] as int) < 0 ? dangerColor :
                                       disabledBoldColor,
                              ),
                              if ((chart["changeFromLastWeek"] as int) != 0)
                                Text(
                                  "${(chart["changeFromLastWeek"] as int).abs()}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: (chart["changeFromLastWeek"] as int) > 0 ? successColor :
                                           dangerColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: spXs),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.play_circle_outline,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNewReleasesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // New Releases Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.new_releases,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fresh Music",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Latest releases from your favorite artists",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "New Albums & Singles",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // New Releases
          Column(
            spacing: spSm,
            children: newReleases.map((release) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    // Cover
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${release["cover"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          if (release["isNewArtist"] as bool)
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: infoColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    SizedBox(width: spMd),
                    
                    // Release Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${release["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${release["artist"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${release["album"]}",
                            style: TextStyle(
                              color: disabledColor,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${release["genre"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (release["isNewArtist"] as bool) ...[
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "New Artist",
                                    style: TextStyle(
                                      color: infoColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${release["trackCount"]} tracks • ${release["duration"]}",
                            style: TextStyle(
                              color: disabledColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Actions
                    Column(
                      children: [
                        Text(
                          "${release["releaseDate"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.play_circle_outline,
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.favorite_border,
                                color: disabledBoldColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
