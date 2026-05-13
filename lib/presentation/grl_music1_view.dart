import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMusic1View extends StatefulWidget {
  @override
  State<GrlMusic1View> createState() => _GrlMusic1ViewState();
}

class _GrlMusic1ViewState extends State<GrlMusic1View> {
  bool isPlaying = false;
  bool isShuffling = false;
  bool isRepeating = false;
  double progressValue = 0.3;
  String currentTime = "01:45";
  String totalTime = "04:32";

  List<Map<String, dynamic>> playlist = [
    {
      "title": "Blinding Lights",
      "artist": "The Weeknd",
      "album": "After Hours",
      "duration": "3:20",
      "image": "https://picsum.photos/60/60?random=1&keyword=music",
      "isCurrentlyPlaying": true,
      "isFavorite": true,
    },
    {
      "title": "Watermelon Sugar",
      "artist": "Harry Styles",
      "album": "Fine Line",
      "duration": "2:54",
      "image": "https://picsum.photos/60/60?random=2&keyword=album",
      "isCurrentlyPlaying": false,
      "isFavorite": false,
    },
    {
      "title": "Levitating",
      "artist": "Dua Lipa",
      "album": "Future Nostalgia",
      "duration": "3:23",
      "image": "https://picsum.photos/60/60?random=3&keyword=cover",
      "isCurrentlyPlaying": false,
      "isFavorite": true,
    },
    {
      "title": "Good 4 U",
      "artist": "Olivia Rodrigo",
      "album": "SOUR",
      "duration": "2:58",
      "image": "https://picsum.photos/60/60?random=4&keyword=song",
      "isCurrentlyPlaying": false,
      "isFavorite": false,
    },
    {
      "title": "Stay",
      "artist": "The Kid LAROI, Justin Bieber",
      "album": "F*CK LOVE 3",
      "duration": "2:21",
      "image": "https://picsum.photos/60/60?random=5&keyword=track",
      "isCurrentlyPlaying": false,
      "isFavorite": true,
    },
    {
      "title": "Heat Waves",
      "artist": "Glass Animals",
      "album": "Dreamland",
      "duration": "3:58",
      "image": "https://picsum.photos/60/60?random=6&keyword=music",
      "isCurrentlyPlaying": false,
      "isFavorite": false,
    },
  ];

  List<Map<String, dynamic>> recentlyPlayed = [
    {
      "title": "As It Was",
      "artist": "Harry Styles",
      "image": "https://picsum.photos/80/80?random=7&keyword=recent",
      "timestamp": "2 hours ago",
    },
    {
      "title": "About Damn Time",
      "artist": "Lizzo",
      "image": "https://picsum.photos/80/80?random=8&keyword=recent",
      "timestamp": "5 hours ago",
    },
    {
      "title": "Running Up That Hill",
      "artist": "Kate Bush",
      "image": "https://picsum.photos/80/80?random=9&keyword=recent",
      "timestamp": "Yesterday",
    },
    {
      "title": "Anti-Hero",
      "artist": "Taylor Swift",
      "image": "https://picsum.photos/80/80?random=10&keyword=recent",
      "timestamp": "2 days ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Now Playing"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.queue_music),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Album Art & Song Info
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor.withAlpha(20),
                    primaryColor.withAlpha(5),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spLg,
                children: [
                  // Album Art
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowLg],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "https://picsum.photos/250/250?random=20&keyword=album",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  // Song Info
                  Column(
                    spacing: spSm,
                    children: [
                      Text(
                        "Blinding Lights",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "The Weeknd",
                        style: TextStyle(
                          fontSize: fsH6,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "After Hours • 2020",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  // Progress Bar
                  Column(
                    spacing: spSm,
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: primaryColor,
                          inactiveTrackColor: disabledColor,
                          thumbColor: primaryColor,
                          trackHeight: 4,
                        ),
                        child: Slider(
                          value: progressValue,
                          onChanged: (value) {
                            setState(() {
                              progressValue = value;
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentTime,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            totalTime,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  // Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Shuffle
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isShuffling 
                              ? primaryColor.withAlpha(20)
                              : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowSm],
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isShuffling = !isShuffling;
                            });
                          },
                          icon: Icon(
                            Icons.shuffle,
                            color: isShuffling ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ),
                      
                      // Previous
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowMd],
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_previous,
                            color: primaryColor,
                            size: 28,
                          ),
                        ),
                      ),
                      
                      // Play/Pause
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [shadowLg],
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isPlaying = !isPlaying;
                            });
                          },
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                      
                      // Next
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowMd],
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_next,
                            color: primaryColor,
                            size: 28,
                          ),
                        ),
                      ),
                      
                      // Repeat
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isRepeating 
                              ? primaryColor.withAlpha(20)
                              : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowSm],
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isRepeating = !isRepeating;
                            });
                          },
                          icon: Icon(
                            Icons.repeat,
                            color: isRepeating ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Additional Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: dangerColor,
                          size: 28,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          color: disabledBoldColor,
                          size: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.download,
                          color: disabledBoldColor,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Up Next Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Up Next",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "View Queue",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Column(
                  spacing: spSm,
                  children: playlist.take(3).map((song) {
                    bool isCurrentSong = song["isCurrentlyPlaying"] as bool;
                    bool isFavorite = song["isFavorite"] as bool;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isCurrentSong 
                            ? primaryColor.withAlpha(10)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: Border.all(
                          color: isCurrentSong 
                              ? primaryColor.withAlpha(30)
                              : disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${song["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${song["title"]}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: isCurrentSong ? primaryColor : primaryColor,
                                  ),
                                ),
                                Text(
                                  "${song["artist"]} • ${song["album"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            spacing: spSm,
                            children: [
                              Text(
                                "${song["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    song["isFavorite"] = !song["isFavorite"];
                                  });
                                },
                                child: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? dangerColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                              Icon(
                                Icons.more_vert,
                                color: disabledBoldColor,
                                size: 20,
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

            // Recently Played
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Recently Played",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QHorizontalScroll(
                  children: recentlyPlayed.map((song) {
                    return Container(
                      width: 140,
                      margin: EdgeInsets.only(right: spMd),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              boxShadow: [shadowSm],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${song["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            spacing: spXs,
                            children: [
                              Text(
                                "${song["title"]}",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${song["artist"]}",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${song["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
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
          ],
        ),
      ),
    );
  }
}
