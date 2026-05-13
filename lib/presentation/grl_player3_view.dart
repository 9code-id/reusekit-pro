import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlayer3View extends StatefulWidget {
  @override
  State<GrlPlayer3View> createState() => _GrlPlayer3ViewState();
}

class _GrlPlayer3ViewState extends State<GrlPlayer3View> {
  int currentTab = 0;
  String currentTrack = "ambient-forest.wav";
  String currentArtist = "Nature Sounds Collective";
  bool isPlaying = false;
  double currentPosition = 0.0;
  String currentTime = "0:00";
  String totalTime = "45:00";

  final List<Map<String, dynamic>> tracks = [
    {
      "title": "Ambient Forest",
      "artist": "Nature Sounds Collective", 
      "duration": "45:00",
      "category": "Nature",
      "waveform": "https://picsum.photos/300/80?random=1&keyword=waveform",
      "playing": false,
    },
    {
      "title": "Ocean Waves Deep",
      "artist": "Relaxation Masters",
      "duration": "60:00", 
      "category": "Water",
      "waveform": "https://picsum.photos/300/80?random=2&keyword=wave",
      "playing": false,
    },
    {
      "title": "Rain on Window",
      "artist": "Sleep Sounds",
      "duration": "30:00",
      "category": "Rain",
      "waveform": "https://picsum.photos/300/80?random=3&keyword=rain",
      "playing": false,
    },
    {
      "title": "City Night Ambience",
      "artist": "Urban Sounds",
      "duration": "120:00",
      "category": "Urban",
      "waveform": "https://picsum.photos/300/80?random=4&keyword=city",
      "playing": false,
    },
    {
      "title": "Tibetan Singing Bowls",
      "artist": "Meditation Music",
      "duration": "25:00",
      "category": "Meditation",
      "waveform": "https://picsum.photos/300/80?random=5&keyword=meditation",
      "playing": false,
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {"name": "All", "icon": Icons.queue_music, "count": 156},
    {"name": "Nature", "icon": Icons.park, "count": 45},
    {"name": "Water", "icon": Icons.waves, "count": 32},
    {"name": "Rain", "icon": Icons.grain, "count": 28},
    {"name": "Urban", "icon": Icons.location_city, "count": 21},
    {"name": "Meditation", "icon": Icons.self_improvement, "count": 30},
  ];

  final List<Map<String, dynamic>> favoriteCategories = [
    {
      "name": "Sleep Sounds",
      "description": "Peaceful sounds for better sleep",
      "tracks": 24,
      "image": "https://picsum.photos/120/120?random=10&keyword=sleep",
      "color": Colors.indigo,
    },
    {
      "name": "Focus Music",
      "description": "Ambient sounds for concentration",
      "tracks": 18,
      "image": "https://picsum.photos/120/120?random=11&keyword=focus",
      "color": Colors.teal,
    },
    {
      "name": "Relaxation",
      "description": "Calming sounds for stress relief",
      "tracks": 32,
      "image": "https://picsum.photos/120/120?random=12&keyword=relax",
      "color": Colors.purple,
    },
  ];

  void _togglePlayPause() {
    isPlaying = !isPlaying;
    setState(() {});
  }

  void _playTrack(Map<String, dynamic> track) {
    currentTrack = "${track["title"]}.wav";
    currentArtist = "${track["artist"]}";
    totalTime = "${track["duration"]}";
    isPlaying = true;
    currentPosition = 0.0;
    currentTime = "0:00";

    for (var item in tracks) {
      item["playing"] = item["title"] == track["title"];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: Column(
        children: [
          // Custom App Bar
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + spSm,
              left: spMd,
              right: spMd,
              bottom: spSm,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withAlpha(20),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => back(),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Text(
                  "Audio Player",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Tab Navigation
          Container(
            color: Color(0xFF1A1A1A),
            child: Row(
              children: [
                _buildTab("Browse", 0),
                _buildTab("Playing", 1),
                _buildTab("Library", 2),
              ],
            ),
          ),

          // Content
          Expanded(
            child: IndexedStack(
              index: currentTab,
              children: [
                _buildBrowseTab(),
                _buildPlayingTab(),
                _buildLibraryTab(),
              ],
            ),
          ),

          // Mini Player
          if (isPlaying) _buildMiniPlayer(),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = currentTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          currentTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spMd),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? primaryColor : Colors.white.withAlpha(120),
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrowseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories
          Text(
            "Categories",
            style: TextStyle(
              color: Colors.white,
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 160,
            children: categories.map((category) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: Colors.white.withAlpha(20),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          category["icon"] as IconData,
                          color: primaryColor,
                          size: 24,
                        ),
                        Spacer(),
                        Text(
                          "${category["count"]}",
                          style: TextStyle(
                            color: Colors.white.withAlpha(120),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          SizedBox(height: spXl),

          // Featured Collections
          Text(
            "Featured Collections",
            style: TextStyle(
              color: Colors.white,
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: favoriteCategories.map((collection) {
              return Container(
                width: 200,
                margin: EdgeInsets.only(right: spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      (collection["color"] as Color).withAlpha(200),
                      (collection["color"] as Color).withAlpha(100),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${collection["image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "${collection["name"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${collection["description"]}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${collection["tracks"]} tracks",
                        style: TextStyle(
                          color: Colors.white.withAlpha(160),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayingTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Current Track Visualization
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPlaying ? Icons.graphic_eq : Icons.music_note,
                  color: primaryColor,
                  size: 48,
                ),
                SizedBox(height: spMd),
                Text(
                  isPlaying ? "Now Playing" : "Select a track to play",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isPlaying) ...[
                  SizedBox(height: spSm),
                  Text(
                    currentArtist,
                    style: TextStyle(
                      color: Colors.white.withAlpha(120),
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Track List
          Expanded(
            child: ListView.builder(
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final track = tracks[index];
                bool isCurrentTrack = track["playing"] as bool;

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isCurrentTrack 
                        ? primaryColor.withAlpha(40) 
                        : Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: isCurrentTrack 
                        ? Border.all(color: primaryColor.withAlpha(100))
                        : null,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _playTrack(track),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isCurrentTrack ? primaryColor : Colors.white.withAlpha(20),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isCurrentTrack && isPlaying 
                                ? Icons.pause 
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${track["title"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${track["artist"]}",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(120),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(120),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${track["category"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${track["duration"]}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(120),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLibraryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "156",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Total Tracks",
                        style: TextStyle(
                          color: Colors.white.withAlpha(120),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "24h",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Total Duration",
                        style: TextStyle(
                          color: Colors.white.withAlpha(120),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: spXl),

          // Library Options
          Text(
            "Your Library",
            style: TextStyle(
              color: Colors.white,
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),

          _buildLibraryOption(
            Icons.favorite,
            "Liked Tracks",
            "32 tracks",
            Colors.red,
          ),
          _buildLibraryOption(
            Icons.history,
            "Recently Played",
            "View history",
            Colors.orange,
          ),
          _buildLibraryOption(
            Icons.download,
            "Downloaded",
            "12 tracks",
            Colors.green,
          ),
          _buildLibraryOption(
            Icons.playlist_play,
            "Custom Playlists",
            "5 playlists",
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildLibraryOption(IconData icon, String title, String subtitle, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(40),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withAlpha(120),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white.withAlpha(120),
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildMiniPlayer() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        border: Border(
          top: BorderSide(
            color: Colors.white.withAlpha(20),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(40),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              Icons.music_note,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Ambient Forest",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  currentArtist,
                  style: TextStyle(
                    color: Colors.white.withAlpha(120),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _togglePlayPause,
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
