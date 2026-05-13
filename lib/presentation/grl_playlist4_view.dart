import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlaylist4View extends StatefulWidget {
  @override
  State<GrlPlaylist4View> createState() => _GrlPlaylist4ViewState();
}

class _GrlPlaylist4ViewState extends State<GrlPlaylist4View> {
  int currentTab = 0;
  String currentTrack = "";
  bool isPlaying = false;
  
  final List<Map<String, dynamic>> tracks = [
    {
      "title": "Midnight City",
      "artist": "M83",
      "duration": "4:03",
      "album": "Hurry Up, We're Dreaming",
      "year": "2011",
      "cover": "https://picsum.photos/300/300?random=1&keyword=city",
      "isLiked": true,
      "addedDate": "2024-01-15",
    },
    {
      "title": "Sunset Lover",
      "artist": "Petit Biscuit",
      "duration": "3:45",
      "album": "Presence",
      "year": "2017",
      "cover": "https://picsum.photos/300/300?random=2&keyword=sunset",
      "isLiked": false,
      "addedDate": "2024-01-10",
    },
    {
      "title": "Breathe Me",
      "artist": "Sia",
      "duration": "4:31",
      "album": "Colour the Small One",
      "year": "2004",
      "cover": "https://picsum.photos/300/300?random=3&keyword=breath",
      "isLiked": true,
      "addedDate": "2024-01-08",
    },
    {
      "title": "Strobe",
      "artist": "Deadmau5",
      "duration": "10:32",
      "album": "For Lack of a Better Name",
      "year": "2009",
      "cover": "https://picsum.photos/300/300?random=4&keyword=strobe",
      "isLiked": false,
      "addedDate": "2024-01-05",
    },
    {
      "title": "Porcelain",
      "artist": "Moby",
      "duration": "4:01",
      "album": "Play",
      "year": "1999",
      "cover": "https://picsum.photos/300/300?random=5&keyword=porcelain",
      "isLiked": true,
      "addedDate": "2024-01-03",
    },
  ];

  final Map<String, dynamic> playlistInfo = {
    "title": "Chill Electronic",
    "description": "A perfect blend of electronic and ambient music for relaxation and focus. Created with love for those peaceful moments.",
    "cover": "https://picsum.photos/400/400?random=10&keyword=electronic",
    "creator": "Alex Johnson",
    "createdDate": "January 2024",
    "followers": 1247,
    "isPublic": true,
    "totalDuration": "26h 52m",
    "trackCount": 45,
    "genre": "Electronic",
    "mood": "Chill",
  };

  final List<Map<String, dynamic>> relatedPlaylists = [
    {
      "title": "Ambient Dreams",
      "creator": "Sound Explorer",
      "tracks": 32,
      "cover": "https://picsum.photos/150/150?random=11&keyword=ambient",
    },
    {
      "title": "Lo-fi Study",
      "creator": "Focus Music",
      "tracks": 28,
      "cover": "https://picsum.photos/150/150?random=12&keyword=lofi",
    },
    {
      "title": "Downtempo Mix",
      "creator": "Chillwave Radio",
      "tracks": 41,
      "cover": "https://picsum.photos/150/150?random=13&keyword=downtempo",
    },
  ];

  void _playTrack(Map<String, dynamic> track) {
    currentTrack = "${track["title"]}";
    isPlaying = true;
    setState(() {});
  }

  void _toggleLike(int index) {
    tracks[index]["isLiked"] = !(tracks[index]["isLiked"] as bool);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header with Playlist Cover
          Container(
            height: 350,
            child: Stack(
              children: [
                // Background Image
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${playlistInfo["cover"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient Overlay
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withAlpha(120),
                        Colors.black.withAlpha(200),
                      ],
                    ),
                  ),
                ),
                // Content
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Navigation
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => back(),
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(100),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(100),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(100),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Spacer(),
                        
                        // Playlist Info
                        Row(
                          children: [
                            // Playlist Cover
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusLg),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(100),
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${playlistInfo["cover"]}",
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
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "PLAYLIST",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "${playlistInfo["title"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "by ${playlistInfo["creator"]}",
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(180),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${playlistInfo["trackCount"]} songs",
                                        style: TextStyle(
                                          color: Colors.white.withAlpha(160),
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(160),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${playlistInfo["totalDuration"]}",
                                        style: TextStyle(
                                          color: Colors.white.withAlpha(160),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: spMd),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "Play",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: spMd),
                            Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(40),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.shuffle,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(40),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tab Navigation
          Container(
            color: Colors.white,
            child: Row(
              children: [
                _buildTab("Songs", 0),
                _buildTab("About", 1),
                _buildTab("Related", 2),
              ],
            ),
          ),

          // Content
          Expanded(
            child: IndexedStack(
              index: currentTab,
              children: [
                _buildSongsTab(),
                _buildAboutTab(),
                _buildRelatedTab(),
              ],
            ),
          ),
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
              color: isSelected ? primaryColor : disabledBoldColor,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSongsTab() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Stats Header
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(
                  Icons.queue_music,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "${tracks.length} songs • ${playlistInfo["totalDuration"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.sort,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),

          // Track List
          Expanded(
            child: ListView.builder(
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final track = tracks[index];
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  child: Row(
                    children: [
                      // Track Number/Play Button
                      Container(
                        width: 40,
                        child: currentTrack == track["title"] && isPlaying
                            ? Icon(
                                Icons.volume_up,
                                color: primaryColor,
                                size: 20,
                              )
                            : Text(
                                "${index + 1}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                      SizedBox(width: spMd),
                      
                      // Album Cover
                      Container(
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusXs),
                          child: Image.network(
                            "${track["cover"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      
                      // Track Info
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _playTrack(track),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${track["title"]}",
                                style: TextStyle(
                                  color: currentTrack == track["title"] && isPlaying
                                      ? primaryColor
                                      : primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "${track["artist"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    width: 3,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: disabledBoldColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${track["album"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Duration
                      Text(
                        "${track["duration"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: spMd),
                      
                      // Like Button
                      GestureDetector(
                        onTap: () => _toggleLike(index),
                        child: Icon(
                          track["isLiked"] as bool 
                              ? Icons.favorite 
                              : Icons.favorite_border,
                          color: track["isLiked"] as bool 
                              ? Colors.red 
                              : disabledBoldColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      
                      // More Options
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.more_vert,
                          color: disabledBoldColor,
                          size: 20,
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

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          Text(
            "About",
            style: TextStyle(
              color: primaryColor,
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "${playlistInfo["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          
          SizedBox(height: spXl),
          
          // Stats
          Text(
            "Statistics",
            style: TextStyle(
              color: primaryColor,
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${playlistInfo["followers"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Followers",
                        style: TextStyle(
                          color: primaryColor,
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
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${playlistInfo["trackCount"]}",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Songs",
                        style: TextStyle(
                          color: successColor,
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
          
          // Details
          Text(
            "Details",
            style: TextStyle(
              color: primaryColor,
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          _buildDetailRow("Genre", "${playlistInfo["genre"]}"),
          _buildDetailRow("Mood", "${playlistInfo["mood"]}"),
          _buildDetailRow("Created", "${playlistInfo["createdDate"]}"),
          _buildDetailRow("Visibility", playlistInfo["isPublic"] as bool ? "Public" : "Private"),
          _buildDetailRow("Total Duration", "${playlistInfo["totalDuration"]}"),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Similar Playlists",
            style: TextStyle(
              color: primaryColor,
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          ...relatedPlaylists.map((playlist) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusXs),
                      child: Image.network(
                        "${playlist["cover"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${playlist["title"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "by ${playlist["creator"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "${playlist["tracks"]} songs",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.play_circle_outline,
                    color: primaryColor,
                    size: 32,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
