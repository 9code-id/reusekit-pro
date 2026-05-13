import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaAlbumDetailView extends StatefulWidget {
  const SmaAlbumDetailView({super.key});

  @override
  State<SmaAlbumDetailView> createState() => _SmaAlbumDetailViewState();
}

class _SmaAlbumDetailViewState extends State<SmaAlbumDetailView> {
  int currentTab = 0;
  bool isPlaying = false;
  int currentTrack = 0;
  double currentPosition = 0.0;
  bool isShuffleOn = false;
  bool isRepeatOn = false;
  bool isLiked = false;

  final Map<String, dynamic> album = {
    "id": "ALB001",
    "title": "Midnight Memories",
    "artist": "Luna Eclipse",
    "releaseDate": "2024-01-15",
    "genre": "Alternative Rock",
    "duration": "3h 24m",
    "totalTracks": 12,
    "coverArt": "https://picsum.photos/300/300?random=1&music",
    "label": "Stellar Records",
    "producer": "Alex Rivera",
    "description": "A captivating journey through the depths of human emotion, 'Midnight Memories' explores themes of love, loss, and redemption with haunting melodies and powerful lyrics.",
    "rating": 4.8,
    "streams": 2500000,
    "likes": 45000,
    "isLiked": false,
    "price": 12.99,
    "isOwned": false,
    "backgroundImage": "https://picsum.photos/400/600?random=10&dark",
    "artistImage": "https://picsum.photos/200/200?random=100&face",
    "socialLinks": {
      "spotify": "https://spotify.com/luna-eclipse",
      "apple": "https://music.apple.com/luna-eclipse",
      "youtube": "https://youtube.com/luna-eclipse",
      "instagram": "@lunaeclipsemusic"
    }
  };

  final List<Map<String, dynamic>> tracks = [
    {
      "id": "T001",
      "title": "Midnight Highway",
      "duration": "4:23",
      "isPlaying": true,
      "position": 0.35,
      "streams": 1200000,
      "isLiked": false,
      "explicit": false,
      "previewUrl": "https://example.com/preview1.mp3"
    },
    {
      "id": "T002",
      "title": "Shadows in the Rain",
      "duration": "3:45",
      "isPlaying": false,
      "position": 0.0,
      "streams": 890000,
      "isLiked": true,
      "explicit": false,
      "previewUrl": "https://example.com/preview2.mp3"
    },
    {
      "id": "T003",
      "title": "Echoes of Tomorrow",
      "duration": "5:12",
      "isPlaying": false,
      "position": 0.0,
      "streams": 756000,
      "isLiked": false,
      "explicit": true,
      "previewUrl": "https://example.com/preview3.mp3"
    },
    {
      "id": "T004",
      "title": "Electric Dreams",
      "duration": "4:01",
      "isPlaying": false,
      "position": 0.0,
      "streams": 1100000,
      "isLiked": false,
      "explicit": false,
      "previewUrl": "https://example.com/preview4.mp3"
    },
    {
      "id": "T005",
      "title": "Broken Wings",
      "duration": "3:56",
      "isPlaying": false,
      "position": 0.0,
      "streams": 945000,
      "isLiked": true,
      "explicit": false,
      "previewUrl": "https://example.com/preview5.mp3"
    },
    {
      "id": "T006",
      "title": "Neon Lights",
      "duration": "4:34",
      "isPlaying": false,
      "position": 0.0,
      "streams": 823000,
      "isLiked": false,
      "explicit": false,
      "previewUrl": "https://example.com/preview6.mp3"
    },
    {
      "id": "T007",
      "title": "Lost in Time",
      "duration": "5:45",
      "isPlaying": false,
      "position": 0.0,
      "streams": 1050000,
      "isLiked": false,
      "explicit": true,
      "previewUrl": "https://example.com/preview7.mp3"
    },
    {
      "id": "T008",
      "title": "Crystal Visions",
      "duration": "3:28",
      "isPlaying": false,
      "position": 0.0,
      "streams": 687000,
      "isLiked": false,
      "explicit": false,
      "previewUrl": "https://example.com/preview8.mp3"
    },
    {
      "id": "T009",
      "title": "Rebel Heart",
      "duration": "4:17",
      "isPlaying": false,
      "position": 0.0,
      "streams": 1300000,
      "isLiked": true,
      "explicit": false,
      "previewUrl": "https://example.com/preview9.mp3"
    },
    {
      "id": "T010",
      "title": "Midnight Sun",
      "duration": "6:12",
      "isPlaying": false,
      "position": 0.0,
      "streams": 934000,
      "isLiked": false,
      "explicit": false,
      "previewUrl": "https://example.com/preview10.mp3"
    },
    {
      "id": "T011",
      "title": "Ethereal Journey",
      "duration": "4:58",
      "isPlaying": false,
      "position": 0.0,
      "streams": 567000,
      "isLiked": false,
      "explicit": false,
      "previewUrl": "https://example.com/preview11.mp3"
    },
    {
      "id": "T012",
      "title": "Epilogue",
      "duration": "7:23",
      "isPlaying": false,
      "position": 0.0,
      "streams": 432000,
      "isLiked": false,
      "explicit": false,
      "previewUrl": "https://example.com/preview12.mp3"
    }
  ];

  final List<Map<String, dynamic>> similarAlbums = [
    {
      "id": "ALB002",
      "title": "Dark Horizon",
      "artist": "Shadow Realm",
      "coverArt": "https://picsum.photos/150/150?random=2&music",
      "rating": 4.6,
      "year": "2023"
    },
    {
      "id": "ALB003",
      "title": "Electric Pulse",
      "artist": "Neon Waves",
      "coverArt": "https://picsum.photos/150/150?random=3&music",
      "rating": 4.4,
      "year": "2024"
    },
    {
      "id": "ALB004",
      "title": "Cosmic Journey",
      "artist": "Star Dust",
      "coverArt": "https://picsum.photos/150/150?random=4&music",
      "rating": 4.7,
      "year": "2023"
    },
    {
      "id": "ALB005",
      "title": "Urban Nights",
      "artist": "City Lights",
      "coverArt": "https://picsum.photos/150/150?random=5&music",
      "rating": 4.5,
      "year": "2024"
    }
  ];

  void _playTrack(int index) {
    for (int i = 0; i < tracks.length; i++) {
      tracks[i]["isPlaying"] = i == index;
    }
    currentTrack = index;
    isPlaying = true;
    setState(() {});
  }

  void _togglePlayPause() {
    isPlaying = !isPlaying;
    setState(() {});
  }

  void _toggleLike(int trackIndex) {
    tracks[trackIndex]["isLiked"] = !tracks[trackIndex]["isLiked"];
    setState(() {});
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Album Cover Hero Section
          Container(
            height: 400,
            width: double.infinity,
            child: Stack(
              children: [
                // Background Image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(
                    "${album["backgroundImage"]}",
                    fit: BoxFit.cover,
                  ),
                ),
                // Gradient Overlay
                Container(
                  width: double.infinity,
                  height: double.infinity,
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
                // Content
                Positioned(
                  bottom: spMd,
                  left: spMd,
                  right: spMd,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Album Cover
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${album["coverArt"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      // Album Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${album["title"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${album["artist"]}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${album["rating"]}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(width: spMd),
                                Text(
                                  "${album["totalTracks"]} tracks",
                                  style: TextStyle(color: Colors.white.withAlpha(200)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Top Actions
                Positioned(
                  top: spMd,
                  left: spMd,
                  right: spMd,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(128),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(128),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.share, color: Colors.white),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          isLiked = !isLiked;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(128),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, primaryColor.withAlpha(200)],
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(radiusLg),
                        onTap: () {
                          _playTrack(0);
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_arrow, color: Colors.white),
                              SizedBox(width: spSm),
                              Text(
                                "Play All",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(radiusLg),
                      onTap: () {
                        isShuffleOn = !isShuffleOn;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.shuffle,
                        color: isShuffleOn ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(radiusLg),
                      onTap: () {},
                      child: Icon(
                        Icons.download,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Album Stats
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${((album["streams"] as int) / 1000000).toStringAsFixed(1)}M",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Streams",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${((album["likes"] as int) / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Likes",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${album["duration"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Duration",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Album Info
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Album Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildInfoRow("Release Date", "${album["releaseDate"]}"),
                _buildInfoRow("Genre", "${album["genre"]}"),
                _buildInfoRow("Label", "${album["label"]}"),
                _buildInfoRow("Producer", "${album["producer"]}"),
                SizedBox(height: spMd),
                Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${album["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTracksTab() {
    return Column(
      children: [
        // Player Controls (if playing)
        if (isPlaying)
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              border: Border(
                bottom: BorderSide(color: primaryColor.withAlpha(50)),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${album["coverArt"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${tracks[currentTrack]["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${album["artist"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _togglePlayPause,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: tracks[currentTrack]["position"] as double,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          ),
        
        // Track List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: tracks.length,
            itemBuilder: (context, index) {
              final track = tracks[index];
              final isCurrentTrack = track["isPlaying"] == true;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isCurrentTrack ? primaryColor.withAlpha(20) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: isCurrentTrack 
                      ? Border.all(color: primaryColor.withAlpha(100))
                      : null,
                ),
                child: Row(
                  children: [
                    // Track Number / Play Button
                    GestureDetector(
                      onTap: () => _playTrack(index),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isCurrentTrack ? primaryColor : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: isCurrentTrack && isPlaying
                              ? Icon(Icons.pause, color: Colors.white)
                              : isCurrentTrack
                                  ? Icon(Icons.play_arrow, color: Colors.white)
                                  : Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    
                    // Track Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${track["title"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isCurrentTrack ? primaryColor : primaryColor,
                                  ),
                                ),
                              ),
                              if (track["explicit"] == true)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Text(
                                    "E",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${track["duration"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Icon(Icons.headphones, size: 14, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${((track["streams"] as int) / 1000).toStringAsFixed(0)}K",
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
                    
                    // Actions
                    GestureDetector(
                      onTap: () => _toggleLike(index),
                      child: Icon(
                        track["isLiked"] == true ? Icons.favorite : Icons.favorite_border,
                        color: track["isLiked"] == true ? Colors.red : disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildArtistTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Artist Info
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor, width: 3),
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage("${album["artistImage"]}"),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${album["artist"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Alternative Rock Artist",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(Icons.people, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "2.5M followers",
                                style: TextStyle(
                                  color: disabledBoldColor,
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
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Follow",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(radiusLg),
                            onTap: () {},
                            child: Center(
                              child: Text(
                                "Message",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Artist Bio
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About the Artist",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "Luna Eclipse is a multi-talented artist known for her haunting vocals and introspective songwriting. With a unique blend of alternative rock and electronic elements, she has captivated audiences worldwide with her emotional depth and musical innovation.",
                  style: TextStyle(
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          
          // Social Links
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Connect with ${album["artist"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 150,
                  children: [
                    _buildSocialButton("Spotify", Icons.music_note, Colors.green),
                    _buildSocialButton("Apple Music", Icons.music_note, Colors.black),
                    _buildSocialButton("YouTube", Icons.play_circle_fill, Colors.red),
                    _buildSocialButton("Instagram", Icons.camera_alt, Colors.purple),
                  ],
                ),
              ],
            ),
          ),
          
          // Similar Albums
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Similar Albums",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 150,
                  children: similarAlbums.map((album) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                "${album["coverArt"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${album["title"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${album["artist"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber, size: 14),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${album["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${album["year"]}",
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
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String label, IconData icon, Color color) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusLg),
          onTap: () {},
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color),
                SizedBox(width: spSm),
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLyricsTab() {
    final lyrics = [
      "Driving down the midnight highway",
      "Stars above are shining bright",
      "Lost in thoughts of yesterday",
      "Searching for the morning light",
      "",
      "Shadows dancing in the rain",
      "Memories come and go",
      "Washing away the pain",
      "Of the things we used to know",
      "",
      "Chorus:",
      "We're just echoes of tomorrow",
      "Fading into the night",
      "Carrying all our sorrow",
      "Until we see the light",
      "",
      "Electric dreams are calling",
      "Through the neon haze",
      "Another star is falling",
      "In this endless maze",
      "",
      "Bridge:",
      "Time keeps moving forward",
      "But we're standing still",
      "Looking for the answers",
      "That we never will",
      "",
      "Chorus:",
      "We're just echoes of tomorrow",
      "Fading into the night",
      "Carrying all our sorrow",
      "Until we see the light",
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Current Track Info
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(30), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "${album["coverArt"]}",
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
                        "${tracks[currentTrack]["title"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${album["artist"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.sync,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          // Lyrics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lyrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...lyrics.map((line) {
                  final isChorus = line.startsWith("Chorus:");
                  final isBridge = line.startsWith("Bridge:");
                  final isEmpty = line.isEmpty;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: isEmpty ? spMd : spSm),
                    child: isEmpty
                        ? SizedBox()
                        : Text(
                            line,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: (isChorus || isBridge) ? FontWeight.bold : FontWeight.normal,
                              color: (isChorus || isBridge) ? primaryColor : disabledBoldColor,
                              height: 1.6,
                            ),
                          ),
                  );
                }).toList(),
              ],
            ),
          ),
          
          // Lyrics Actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lyrics Actions",
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
                        label: "Share Lyrics",
                        icon: Icons.share,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(radiusLg),
                            onTap: () {},
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.translate, color: primaryColor, size: 16),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Translate",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Album Details",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.album)),
        Tab(text: "Tracks", icon: Icon(Icons.queue_music)),
        Tab(text: "Artist", icon: Icon(Icons.person)),
        Tab(text: "Lyrics", icon: Icon(Icons.lyrics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTracksTab(),
        _buildArtistTab(),
        _buildLyricsTab(),
      ],
    );
  }
}
