import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAudio1View extends StatefulWidget {
  @override
  State<GrlAudio1View> createState() => _GrlAudio1ViewState();
}

class _GrlAudio1ViewState extends State<GrlAudio1View> {
  List<Map<String, dynamic>> audioTracks = [
    {
      "id": 1,
      "title": "Summer Vibes",
      "artist": "Ocean Waves",
      "album": "Relaxation Sounds",
      "duration": "3:45",
      "image": "https://picsum.photos/300/300?random=1&keyword=music",
      "genre": "Ambient",
      "isPlaying": false,
      "isLiked": true,
      "playCount": 1250
    },
    {
      "id": 2,
      "title": "Mountain Echo",
      "artist": "Nature Sounds",
      "album": "Peaceful Moments",
      "duration": "4:22",
      "image": "https://picsum.photos/300/300?random=2&keyword=nature",
      "genre": "Nature",
      "isPlaying": true,
      "isLiked": false,
      "playCount": 890
    },
    {
      "id": 3,
      "title": "City Lights",
      "artist": "Urban Beats",
      "album": "Metropolitan",
      "duration": "2:58",
      "image": "https://picsum.photos/300/300?random=3&keyword=city",
      "genre": "Electronic",
      "isPlaying": false,
      "isLiked": true,
      "playCount": 2340
    },
    {
      "id": 4,
      "title": "Forest Rain",
      "artist": "Natural Elements",
      "album": "Earth Sounds",
      "duration": "5:12",
      "image": "https://picsum.photos/300/300?random=4&keyword=forest",
      "genre": "Nature",
      "isPlaying": false,
      "isLiked": false,
      "playCount": 670
    },
    {
      "id": 5,
      "title": "Jazz Cafe",
      "artist": "Smooth Jazz Collective",
      "album": "Evening Sessions",
      "duration": "4:35",
      "image": "https://picsum.photos/300/300?random=5&keyword=jazz",
      "genre": "Jazz",
      "isPlaying": false,
      "isLiked": true,
      "playCount": 1890
    }
  ];

  List<Map<String, dynamic>> playlists = [
    {
      "id": 1,
      "name": "Relaxation Mix",
      "trackCount": 24,
      "duration": "1h 45m",
      "image": "https://picsum.photos/200/200?random=6&keyword=relax",
      "isPublic": true
    },
    {
      "id": 2,
      "name": "Work Focus",
      "trackCount": 18,
      "duration": "1h 12m",
      "image": "https://picsum.photos/200/200?random=7&keyword=focus",
      "isPublic": false
    },
    {
      "id": 3,
      "name": "Sleep Sounds",
      "trackCount": 12,
      "duration": "2h 30m",
      "image": "https://picsum.photos/200/200?random=8&keyword=sleep",
      "isPublic": true
    }
  ];

  String selectedGenre = "All";
  List<String> genres = ["All", "Ambient", "Nature", "Electronic", "Jazz", "Classical"];
  int currentlyPlaying = 2;

  @override
  Widget build(BuildContext context) {
    final filteredTracks = selectedGenre == "All" 
        ? audioTracks 
        : audioTracks.where((track) => track["genre"] == selectedGenre).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Library"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.queue_music),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Now Playing Banner
            if (audioTracks.any((track) => track["isPlaying"] == true))
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        image: DecorationImage(
                          image: NetworkImage("${audioTracks.firstWhere((track) => track["isPlaying"] == true)["image"]}"),
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
                            "Now Playing",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Text(
                            "${audioTracks.firstWhere((track) => track["isPlaying"] == true)["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${audioTracks.firstWhere((track) => track["isPlaying"] == true)["artist"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.pause,
                      size: bs.sm,
                      onPressed: () {
                        audioTracks.firstWhere((track) => track["isPlaying"] == true)["isPlaying"] = false;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

            if (audioTracks.any((track) => track["isPlaying"] == true))
              SizedBox(height: spLg),

            // Quick Playlists
            Text(
              "Your Playlists",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QHorizontalScroll(
              children: playlists.map((playlist) {
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                          image: DecorationImage(
                            image: NetworkImage("${playlist["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(100),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (playlist["isPublic"] == true)
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.public,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                  ],
                                ),
                                QButton(
                                  icon: Icons.play_arrow,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${playlist["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${playlist["trackCount"]} tracks",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${playlist["duration"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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

            SizedBox(height: spLg),

            // Genre Filter
            Text(
              "Browse by Genre",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QCategoryPicker(
              items: genres.map((genre) => {
                "label": genre,
                "value": genre,
              }).toList(),
              value: selectedGenre,
              onChanged: (index, label, value, item) {
                selectedGenre = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Audio Tracks
            Text(
              "All Tracks",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Column(
              children: filteredTracks.map((track) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: track["isPlaying"] == true 
                        ? primaryColor.withAlpha(50) 
                        : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: track["isPlaying"] == true 
                        ? Border.all(color: primaryColor, width: 1)
                        : null,
                  ),
                  child: Row(
                    children: [
                      // Track Image
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${track["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: track["isPlaying"] == true
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  color: Colors.black.withAlpha(100),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.volume_up,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      SizedBox(width: spSm),

                      // Track Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${track["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: track["isPlaying"] == true 
                                    ? primaryColor 
                                    : primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${track["artist"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: secondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${track["album"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${track["genre"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${track["duration"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.play_circle,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${track["playCount"]} plays",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Actions
                      Column(
                        children: [
                          QButton(
                            icon: track["isLiked"] == true ? Icons.favorite : Icons.favorite_border,
                            size: bs.sm,
                            onPressed: () {
                              track["isLiked"] = !track["isLiked"];
                              setState(() {});
                            },
                          ),
                          SizedBox(height: spXs),
                          QButton(
                            icon: track["isPlaying"] == true ? Icons.pause : Icons.play_arrow,
                            size: bs.sm,
                            onPressed: () {
                              // Stop other tracks
                              for (var t in audioTracks) {
                                t["isPlaying"] = false;
                              }
                              // Play this track
                              track["isPlaying"] = !track["isPlaying"];
                              setState(() {});
                            },
                          ),
                          SizedBox(height: spXs),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {},
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
