import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHome9View extends StatefulWidget {
  @override
  State<GrlHome9View> createState() => _GrlHome9ViewState();
}

class _GrlHome9ViewState extends State<GrlHome9View> {
  String searchQuery = "";
  int selectedMoodIndex = 0;
  
  final List<Map<String, dynamic>> moodOptions = [
    {"label": "All", "value": "all", "icon": Icons.all_inclusive},
    {"label": "Happy", "value": "happy", "icon": Icons.sentiment_very_satisfied},
    {"label": "Chill", "value": "chill", "icon": Icons.self_improvement},
    {"label": "Focus", "value": "focus", "icon": Icons.psychology},
  ];

  final List<Map<String, dynamic>> featuredPlaylists = [
    {
      "id": 1,
      "title": "Today's Top Hits",
      "subtitle": "The most popular songs right now",
      "image": "https://picsum.photos/300/300?random=1&keyword=music",
      "songCount": 50,
      "totalDuration": "3h 25m",
      "plays": 2450000,
      "genre": "Pop",
      "isOfficial": true,
      "color": primaryColor,
    },
    {
      "id": 2,
      "title": "Chill Vibes",
      "subtitle": "Relaxing beats for your day",
      "image": "https://picsum.photos/300/300?random=2&keyword=chill",
      "songCount": 32,
      "totalDuration": "2h 15m",
      "plays": 1230000,
      "genre": "Lo-fi",
      "isOfficial": false,
      "color": successColor,
    },
    {
      "id": 3,
      "title": "Workout Energy",
      "subtitle": "High-energy tracks for fitness",
      "image": "https://picsum.photos/300/300?random=3&keyword=workout",
      "songCount": 40,
      "totalDuration": "2h 45m",
      "plays": 890000,
      "genre": "Electronic",
      "isOfficial": true,
      "color": dangerColor,
    },
    {
      "id": 4,
      "title": "Jazz Classics",
      "subtitle": "Timeless jazz masterpieces",
      "image": "https://picsum.photos/300/300?random=4&keyword=jazz",
      "songCount": 28,
      "totalDuration": "1h 55m",
      "plays": 567000,
      "genre": "Jazz",
      "isOfficial": true,
      "color": warningColor,
    },
  ];

  final List<Map<String, dynamic>> recentlyPlayed = [
    {
      "title": "Blinding Lights",
      "artist": "The Weeknd",
      "album": "After Hours",
      "duration": "3:20",
      "image": "https://picsum.photos/60/60?random=5&keyword=album",
      "isPlaying": false,
    },
    {
      "title": "Watermelon Sugar",
      "artist": "Harry Styles",
      "album": "Fine Line",
      "duration": "2:54",
      "image": "https://picsum.photos/60/60?random=6&keyword=album",
      "isPlaying": true,
    },
    {
      "title": "Levitating",
      "artist": "Dua Lipa",
      "album": "Future Nostalgia",
      "duration": "3:23",
      "image": "https://picsum.photos/60/60?random=7&keyword=album",
      "isPlaying": false,
    },
    {
      "title": "Good 4 U",
      "artist": "Olivia Rodrigo",
      "album": "SOUR",
      "duration": "2:58",
      "image": "https://picsum.photos/60/60?random=8&keyword=album",
      "isPlaying": false,
    },
  ];

  final List<Map<String, dynamic>> topArtists = [
    {
      "name": "Taylor Swift",
      "genre": "Pop",
      "monthlyListeners": 85234000,
      "image": "https://picsum.photos/100/100?random=9&keyword=artist",
      "isVerified": true,
    },
    {
      "name": "Ed Sheeran",
      "genre": "Pop Rock",
      "monthlyListeners": 72156000,
      "image": "https://picsum.photos/100/100?random=10&keyword=artist",
      "isVerified": true,
    },
    {
      "name": "Drake",
      "genre": "Hip Hop",
      "monthlyListeners": 68945000,
      "image": "https://picsum.photos/100/100?random=11&keyword=artist",
      "isVerified": true,
    },
    {
      "name": "Billie Eilish",
      "genre": "Alternative",
      "monthlyListeners": 61234000,
      "image": "https://picsum.photos/100/100?random=12&keyword=artist",
      "isVerified": true,
    },
  ];

  final List<Map<String, dynamic>> musicGenres = [
    {
      "name": "Pop",
      "icon": Icons.music_note,
      "color": primaryColor,
      "trackCount": 45000,
      "description": "Popular mainstream music",
    },
    {
      "name": "Rock",
      "icon": Icons.audio_file,
      "color": dangerColor,
      "trackCount": 32000,
      "description": "Classic and modern rock",
    },
    {
      "name": "Hip Hop",
      "icon": Icons.queue_music,
      "color": warningColor,
      "trackCount": 28000,
      "description": "Rap and urban beats",
    },
    {
      "name": "Electronic",
      "icon": Icons.graphic_eq,
      "color": infoColor,
      "trackCount": 21000,
      "description": "EDM and electronic music",
    },
    {
      "name": "Jazz",
      "icon": Icons.piano,
      "color": successColor,
      "trackCount": 15000,
      "description": "Classic and contemporary jazz",
    },
    {
      "name": "Classical",
      "icon": Icons.library_music,
      "color": primaryColor,
      "trackCount": 12000,
      "description": "Orchestral and chamber music",
    },
  ];

  final List<Map<String, dynamic>> userStats = [
    {
      "title": "Hours Listened",
      "value": "127",
      "subtitle": "This month",
      "icon": Icons.headphones,
      "color": primaryColor,
    },
    {
      "title": "Songs Played",
      "value": "2,340",
      "subtitle": "All time",
      "icon": Icons.music_note,
      "color": successColor,
    },
    {
      "title": "Playlists",
      "value": "18",
      "subtitle": "Created",
      "icon": Icons.playlist_play,
      "color": infoColor,
    },
    {
      "title": "Followers",
      "value": "456",
      "subtitle": "Following you",
      "icon": Icons.people,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Hub"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.library_music),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [dangerColor, dangerColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Music, Your Mood",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Discover new tracks and enjoy your favorites",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.music_note,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      QButton(
                        label: "Discover Music",
                        color: Colors.white,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "My Library",
                        color: Colors.white.withAlpha(100),
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search and Mood Selector
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search songs, artists, albums...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  QHorizontalScroll(
                    children: moodOptions.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> mood = entry.value;
                      bool isSelected = selectedMoodIndex == index;
                      
                      return Container(
                        margin: EdgeInsets.only(
                          left: index == 0 ? 0 : spXs,
                          right: index == moodOptions.length - 1 ? 0 : spXs,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledColor.withAlpha(100),
                          ),
                          boxShadow: isSelected ? [shadowSm] : [],
                        ),
                        child: Row(
                          spacing: spXs,
                          children: [
                            Icon(
                              mood["icon"] as IconData,
                              size: 16,
                              color: isSelected ? Colors.white : primaryColor,
                            ),
                            Text(
                              "${mood["label"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : primaryColor,
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

            // User Stats
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Music Stats",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 140,
                    children: userStats.map((stat) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: (stat["color"] as Color).withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    stat["icon"] as IconData,
                                    size: 20,
                                    color: stat["color"] as Color,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            Text(
                              "${stat["value"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${stat["title"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${stat["subtitle"]}",
                              style: TextStyle(
                                fontSize: 9,
                                color: disabledColor,
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

            // Featured Playlists
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Row(
                    children: [
                      Text(
                        "Featured Playlists",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                QHorizontalScroll(
                  children: featuredPlaylists.map((playlist) {
                    return Container(
                      width: 200,
                      margin: EdgeInsets.only(
                        left: spMd,
                        right: playlist == featuredPlaylists.last ? spMd : 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowMd],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                                child: Image.network(
                                  "${playlist["image"]}",
                                  width: double.infinity,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (playlist["isOfficial"] as bool)
                                Positioned(
                                  top: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "OFFICIAL",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              Positioned(
                                bottom: spSm,
                                right: spSm,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: (playlist["color"] as Color),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                    boxShadow: [shadowSm],
                                  ),
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 20,
                                    color: Colors.white,
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
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: (playlist["color"] as Color).withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${playlist["genre"]}",
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: playlist["color"] as Color,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${playlist["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${playlist["subtitle"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${playlist["songCount"]} songs",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: disabledColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "•",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: disabledColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${playlist["totalDuration"]}",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${((playlist["plays"] as int) / 1000000).toStringAsFixed(1)}M plays",
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: playlist["color"] as Color,
                                  ),
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

            // Music Genres
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Browse by Genre",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 100,
                    children: musicGenres.map((genre) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: (genre["color"] as Color).withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                genre["icon"] as IconData,
                                size: 22,
                                color: genre["color"] as Color,
                              ),
                            ),
                            Text(
                              "${genre["name"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${((genre["trackCount"] as int) / 1000).toStringAsFixed(0)}K tracks",
                              style: TextStyle(
                                fontSize: 9,
                                color: disabledBoldColor,
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

            // Recently Played
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recently Played",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: recentlyPlayed.map((song) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${song["image"]}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (song["isPlaying"] as bool)
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(100),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Icon(
                                        Icons.pause,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${song["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${song["artist"]} • ${song["album"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${song["duration"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledColor,
                                  ),
                                ),
                                Icon(
                                  Icons.more_vert,
                                  size: 16,
                                  color: disabledColor,
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
            ),

            // Top Artists
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Row(
                    children: [
                      Text(
                        "Top Artists",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                QHorizontalScroll(
                  children: topArtists.map((artist) {
                    return Container(
                      width: 130,
                      margin: EdgeInsets.only(
                        left: spMd,
                        right: artist == topArtists.last ? spMd : 0,
                      ),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${artist["image"]}",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (artist["isVerified"] as bool)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusLg),
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                    child: Icon(
                                      Icons.verified,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Text(
                            "${artist["name"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${artist["genre"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${((artist["monthlyListeners"] as int) / 1000000).toStringAsFixed(1)}M listeners",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 9,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // Bottom spacing
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
