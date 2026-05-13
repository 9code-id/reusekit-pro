import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscover2View extends StatefulWidget {
  @override
  State<GrlDiscover2View> createState() => _GrlDiscover2ViewState();
}

class _GrlDiscover2ViewState extends State<GrlDiscover2View> {
  String searchQuery = "";
  String selectedGenre = "All Genres";
  String selectedArtist = "All Artists";
  String selectedYear = "All Years";
  String selectedSort = "Popular";
  bool showExplicitOnly = false;
  
  List<Map<String, dynamic>> genreOptions = [
    {"label": "All Genres", "value": "All Genres"},
    {"label": "Pop", "value": "Pop"},
    {"label": "Rock", "value": "Rock"},
    {"label": "Hip Hop", "value": "Hip Hop"},
    {"label": "Electronic", "value": "Electronic"},
    {"label": "Jazz", "value": "Jazz"},
    {"label": "Classical", "value": "Classical"},
    {"label": "R&B", "value": "R&B"},
    {"label": "Country", "value": "Country"},
  ];
  
  List<Map<String, dynamic>> artistOptions = [
    {"label": "All Artists", "value": "All Artists"},
    {"label": "Taylor Swift", "value": "Taylor Swift"},
    {"label": "The Weeknd", "value": "The Weeknd"},
    {"label": "Billie Eilish", "value": "Billie Eilish"},
    {"label": "Drake", "value": "Drake"},
    {"label": "Ariana Grande", "value": "Ariana Grande"},
  ];
  
  List<Map<String, dynamic>> yearOptions = [
    {"label": "All Years", "value": "All Years"},
    {"label": "2024-2025", "value": "2024-2025"},
    {"label": "2020-2023", "value": "2020-2023"},
    {"label": "2015-2019", "value": "2015-2019"},
    {"label": "2010-2014", "value": "2010-2014"},
    {"label": "Before 2010", "value": "Before 2010"},
  ];
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Popular", "value": "Popular"},
    {"label": "Release Date", "value": "Release Date"},
    {"label": "Alphabetical", "value": "Alphabetical"},
    {"label": "Duration", "value": "Duration"},
    {"label": "Play Count", "value": "Play Count"},
  ];
  
  List<Map<String, dynamic>> tracks = [
    {
      "id": 1,
      "title": "Anti-Hero",
      "artist": "Taylor Swift",
      "album": "Midnights",
      "genre": "Pop",
      "year": 2022,
      "duration": "3:21",
      "playCount": 1234567890,
      "isExplicit": false,
      "isPopular": true,
      "isNewRelease": false,
      "isTrending": true,
      "artwork": "https://picsum.photos/300/300?random=1&keyword=taylor",
      "previewUrl": "audio_preview_1.mp3",
      "albumArtwork": "https://picsum.photos/600/600?random=1&keyword=midnights",
      "label": "Republic Records",
      "releaseDate": "October 21, 2022",
      "features": [],
      "spotifyUrl": "spotify:track:example1",
      "appleUrl": "apple.music/example1",
    },
    {
      "id": 2,
      "title": "Blinding Lights",
      "artist": "The Weeknd",
      "album": "After Hours",
      "genre": "R&B",
      "year": 2019,
      "duration": "3:20",
      "playCount": 2134567890,
      "isExplicit": false,
      "isPopular": true,
      "isNewRelease": false,
      "isTrending": false,
      "artwork": "https://picsum.photos/300/300?random=2&keyword=weeknd",
      "previewUrl": "audio_preview_2.mp3",
      "albumArtwork": "https://picsum.photos/600/600?random=2&keyword=afterhours",
      "label": "XO/Republic Records",
      "releaseDate": "November 29, 2019",
      "features": [],
      "spotifyUrl": "spotify:track:example2",
      "appleUrl": "apple.music/example2",
    },
    {
      "id": 3,
      "title": "Bad Guy",
      "artist": "Billie Eilish",
      "album": "When We All Fall Asleep, Where Do We Go?",
      "genre": "Pop",
      "year": 2019,
      "duration": "3:14",
      "playCount": 1876543210,
      "isExplicit": true,
      "isPopular": true,
      "isNewRelease": false,
      "isTrending": false,
      "artwork": "https://picsum.photos/300/300?random=3&keyword=billie",
      "previewUrl": "audio_preview_3.mp3",
      "albumArtwork": "https://picsum.photos/600/600?random=3&keyword=billie",
      "label": "Interscope Records",
      "releaseDate": "March 29, 2019",
      "features": [],
      "spotifyUrl": "spotify:track:example3",
      "appleUrl": "apple.music/example3",
    },
    {
      "id": 4,
      "title": "God's Plan",
      "artist": "Drake",
      "album": "Scorpion",
      "genre": "Hip Hop",
      "year": 2018,
      "duration": "3:19",
      "playCount": 1654321098,
      "isExplicit": true,
      "isPopular": true,
      "isNewRelease": false,
      "isTrending": true,
      "artwork": "https://picsum.photos/300/300?random=4&keyword=drake",
      "previewUrl": "audio_preview_4.mp3",
      "albumArtwork": "https://picsum.photos/600/600?random=4&keyword=scorpion",
      "label": "OVO Sound/Republic Records",
      "releaseDate": "January 19, 2018",
      "features": [],
      "spotifyUrl": "spotify:track:example4",
      "appleUrl": "apple.music/example4",
    },
    {
      "id": 5,
      "title": "positions",
      "artist": "Ariana Grande",
      "album": "Positions",
      "genre": "Pop",
      "year": 2020,
      "duration": "2:52",
      "playCount": 987654321,
      "isExplicit": true,
      "isPopular": false,
      "isNewRelease": true,
      "isTrending": false,
      "artwork": "https://picsum.photos/300/300?random=5&keyword=ariana",
      "previewUrl": "audio_preview_5.mp3",
      "albumArtwork": "https://picsum.photos/600/600?random=5&keyword=positions",
      "label": "Republic Records",
      "releaseDate": "October 30, 2020",
      "features": [],
      "spotifyUrl": "spotify:track:example5",
      "appleUrl": "apple.music/example5",
    },
    {
      "id": 6,
      "title": "Levitating",
      "artist": "Dua Lipa",
      "album": "Future Nostalgia",
      "genre": "Pop",
      "year": 2020,
      "duration": "3:23",
      "playCount": 1345678901,
      "isExplicit": false,
      "isPopular": true,
      "isNewRelease": false,
      "isTrending": true,
      "artwork": "https://picsum.photos/300/300?random=6&keyword=dua",
      "previewUrl": "audio_preview_6.mp3",
      "albumArtwork": "https://picsum.photos/600/600?random=6&keyword=future",
      "label": "Warner Records",
      "releaseDate": "March 27, 2020",
      "features": ["DaBaby"],
      "spotifyUrl": "spotify:track:example6",
      "appleUrl": "apple.music/example6",
    },
  ];
  
  List<Map<String, dynamic>> get filteredTracks {
    return tracks.where((track) {
      bool matchesSearch = track["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          track["artist"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          track["album"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesGenre = selectedGenre == "All Genres" || track["genre"] == selectedGenre;
      bool matchesArtist = selectedArtist == "All Artists" || track["artist"] == selectedArtist;
      bool matchesExplicit = !showExplicitOnly || track["isExplicit"];
      
      return matchesSearch && matchesGenre && matchesArtist && matchesExplicit;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Discovery"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.queue_music),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Now Playing Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    secondaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "https://picsum.photos/60/60?random=10&keyword=music",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Now Playing",
                          style: TextStyle(
                            color: Colors.white.withAlpha(220),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Flowers",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Miley Cyrus",
                          style: TextStyle(
                            color: Colors.white.withAlpha(220),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.pause,
                            color: primaryColor,
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
                            color: Colors.white.withAlpha(40),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.skip_next,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Search Bar
            QTextField(
              label: "Search songs, artists, albums...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Quick Categories
            Text(
              "Discover Music",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: [
                _buildMusicCategory("Trending", Icons.trending_up, dangerColor),
                _buildMusicCategory("New Releases", Icons.fiber_new, successColor),
                _buildMusicCategory("Top Charts", Icons.equalizer, warningColor),
                _buildMusicCategory("Playlists", Icons.queue_music, primaryColor),
                _buildMusicCategory("Radio", Icons.radio, infoColor),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Filters
            Text(
              "Filters",
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
                  child: QDropdownField(
                    label: "Genre",
                    items: genreOptions,
                    value: selectedGenre,
                    onChanged: (value, label) {
                      selectedGenre = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Artist",
                    items: artistOptions,
                    value: selectedArtist,
                    onChanged: (value, label) {
                      selectedArtist = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Explicit Content Toggle
            Row(
              children: [
                Text(
                  "Show explicit content only",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Switch(
                  value: showExplicitOnly,
                  onChanged: (value) {
                    showExplicitOnly = value;
                    setState(() {});
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Results Header
            Row(
              children: [
                Text(
                  "${filteredTracks.length} Songs",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        "Sort",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Icon(
                        Icons.sort,
                        color: secondaryColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Tracks List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredTracks.length,
              itemBuilder: (context, index) {
                final track = filteredTracks[index];
                
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
                      // Album Artwork
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${track["artwork"]}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          // Play Button Overlay
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                color: Colors.black.withAlpha(100),
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
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
                      
                      // Track Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Track Title with Badges
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${track["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (track["isExplicit"])
                                  Container(
                                    margin: EdgeInsets.only(left: spXs),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: disabledBoldColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "E",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                if (track["isTrending"])
                                  Container(
                                    margin: EdgeInsets.only(left: spXs),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "HOT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            
                            SizedBox(height: spXs),
                            
                            // Artist and Album
                            Text(
                              "${track["artist"]} • ${track["album"]}",
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            SizedBox(height: spXs),
                            
                            // Genre, Year, Duration
                            Row(
                              children: [
                                Text(
                                  "${track["genre"]} • ${track["year"]} • ${track["duration"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${((track["playCount"] as int) / 1000000).toStringAsFixed(1)}M plays",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      // Action Buttons
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                color: primaryColor,
                                size: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: secondaryColor.withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                color: secondaryColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            
            SizedBox(height: spLg),
            
            // Streaming Links
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Listen on Your Favorite Platform",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStreamingButton("Spotify", Icons.music_note, successColor),
                      _buildStreamingButton("Apple Music", Icons.music_video, disabledBoldColor),
                      _buildStreamingButton("YouTube", Icons.play_circle, dangerColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMusicCategory(String label, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 100,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: color.withAlpha(50),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildStreamingButton(String label, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: spSm,
          vertical: spSm,
        ),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: color.withAlpha(50),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
