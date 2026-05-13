import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlList10View extends StatefulWidget {
  @override
  State<GrlList10View> createState() => _GrlList10ViewState();
}

class _GrlList10ViewState extends State<GrlList10View> {
  String searchQuery = "";
  String selectedGenre = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> genreOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pop", "value": "Pop"},
    {"label": "Rock", "value": "Rock"},
    {"label": "Jazz", "value": "Jazz"},
    {"label": "Classical", "value": "Classical"},
    {"label": "Electronic", "value": "Electronic"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Playing", "value": "Playing"},
    {"label": "Paused", "value": "Paused"},
    {"label": "Stopped", "value": "Stopped"},
  ];

  List<Map<String, dynamic>> songs = [
    {
      "id": "SONG-001",
      "title": "Midnight Dreams",
      "artist": "Luna Eclipse",
      "album": "Starlight Sessions",
      "genre": "Pop",
      "duration": "3:45",
      "durationSeconds": 225,
      "releaseDate": "2024-03-15",
      "plays": 1250000,
      "likes": 45600,
      "artwork": "https://picsum.photos/300/300?random=91&keyword=music",
      "isPlaying": false,
      "isPaused": false,
      "isFavorite": true,
      "isDownloaded": true,
      "status": "Stopped",
      "quality": "High",
      "rating": 4.8,
    },
    {
      "id": "SONG-002",
      "title": "Electric Nights",
      "artist": "Neon Pulse",
      "album": "Digital Paradise",
      "genre": "Electronic",
      "duration": "4:12",
      "durationSeconds": 252,
      "releaseDate": "2024-02-20",
      "plays": 890000,
      "likes": 32400,
      "artwork": "https://picsum.photos/300/300?random=92&keyword=music",
      "isPlaying": true,
      "isPaused": false,
      "isFavorite": false,
      "isDownloaded": true,
      "status": "Playing",
      "quality": "Ultra",
      "rating": 4.6,
    },
    {
      "id": "SONG-003",
      "title": "Mountain High",
      "artist": "Wild Rivers",
      "album": "Nature's Call",
      "genre": "Rock",
      "duration": "5:33",
      "durationSeconds": 333,
      "releaseDate": "2024-01-10",
      "plays": 2100000,
      "likes": 78900,
      "artwork": "https://picsum.photos/300/300?random=93&keyword=music",
      "isPlaying": false,
      "isPaused": true,
      "isFavorite": true,
      "isDownloaded": false,
      "status": "Paused",
      "quality": "High",
      "rating": 4.9,
    },
    {
      "id": "SONG-004",
      "title": "Smooth Operator",
      "artist": "Jazz Collective",
      "album": "Midnight Jazz",
      "genre": "Jazz",
      "duration": "6:18",
      "durationSeconds": 378,
      "releaseDate": "2023-12-05",
      "plays": 567000,
      "likes": 23100,
      "artwork": "https://picsum.photos/300/300?random=94&keyword=music",
      "isPlaying": false,
      "isPaused": false,
      "isFavorite": false,
      "isDownloaded": true,
      "status": "Stopped",
      "quality": "High",
      "rating": 4.7,
    },
    {
      "id": "SONG-005",
      "title": "Symphony No. 9",
      "artist": "Metropolitan Orchestra",
      "album": "Classical Masterpieces",
      "genre": "Classical",
      "duration": "12:45",
      "durationSeconds": 765,
      "releaseDate": "2024-04-22",
      "plays": 345000,
      "likes": 18700,
      "artwork": "https://picsum.photos/300/300?random=95&keyword=music",
      "isPlaying": false,
      "isPaused": false,
      "isFavorite": true,
      "isDownloaded": false,
      "status": "Stopped",
      "quality": "Ultra",
      "rating": 4.9,
    },
  ];

  List<Map<String, dynamic>> get filteredSongs {
    return songs.where((song) {
      bool matchesSearch = "${song["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${song["artist"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${song["album"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesGenre = selectedGenre == "All" || song["genre"] == selectedGenre;
      bool matchesStatus = selectedStatus == "All" || song["status"] == selectedStatus;
      return matchesSearch && matchesGenre && matchesStatus;
    }).toList();
  }

  Color getGenreColor(String genre) {
    switch (genre) {
      case "Pop":
        return Color(0xFFFF6B9D);
      case "Rock":
        return Color(0xFFFF4444);
      case "Jazz":
        return Color(0xFF8B5CF6);
      case "Classical":
        return Color(0xFF059669);
      case "Electronic":
        return Color(0xFF0EA5E9);
      default:
        return disabledBoldColor;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Playing":
        return successColor;
      case "Paused":
        return warningColor;
      case "Stopped":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  String formatPlays(int plays) {
    if (plays >= 1000000) {
      return "${(plays / 1000000).toStringAsFixed(1)}M";
    } else if (plays >= 1000) {
      return "${(plays / 1000).toStringAsFixed(1)}K";
    }
    return plays.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Library"),
        actions: [
          Icon(Icons.queue_music),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6366F1),
                    Color(0xFF8B5CF6),
                    Color(0xFFEC4899),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.library_music,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Your Music Collection",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${songs.length} songs",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              " • ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "${songs.where((s) => s["isDownloaded"] == true).length} downloaded",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
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

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search music",
                    value: searchQuery,
                    hint: "Search by title, artist, or album...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

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
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Songs (${filteredSongs.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    QButton(
                      icon: Icons.shuffle,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    QButton(
                      icon: Icons.play_arrow,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredSongs.length,
              itemBuilder: (context, index) {
                final song = filteredSongs[index];
                final genreColor = getGenreColor("${song["genre"]}");
                final statusColor = getStatusColor("${song["status"]}");
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: (song["isPlaying"] as bool)
                        ? Border.all(color: successColor, width: 2)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${song["artwork"]}",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (song["isPlaying"] as bool)
                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.volume_up,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          if (song["isDownloaded"] as bool)
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: infoColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.download_done,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${song["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${song["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${song["artist"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor,
                              ),
                            ),
                            Text(
                              "${song["album"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: genreColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${song["genre"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: genreColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < (song["rating"] as double).floor()
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: warningColor,
                                      size: 12,
                                    );
                                  }),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${song["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: spMd,
                                  children: [
                                    Row(
                                      spacing: spXs,
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: disabledBoldColor,
                                          size: 14,
                                        ),
                                        Text(
                                          "${song["duration"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: spXs,
                                      children: [
                                        Icon(
                                          Icons.play_arrow,
                                          color: disabledBoldColor,
                                          size: 14,
                                        ),
                                        Text(
                                          formatPlays(song["plays"] as int),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: spXs,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            song["isFavorite"] = !(song["isFavorite"] as bool);
                                            if (song["isFavorite"] as bool) {
                                              song["likes"] = (song["likes"] as int) + 1;
                                            } else {
                                              song["likes"] = (song["likes"] as int) - 1;
                                            }
                                            setState(() {});
                                          },
                                          child: Icon(
                                            (song["isFavorite"] as bool)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: (song["isFavorite"] as bool)
                                                ? dangerColor
                                                : disabledBoldColor,
                                            size: 14,
                                          ),
                                        ),
                                        Text(
                                          formatPlays(song["likes"] as int),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${song["quality"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Column(
                        spacing: spXs,
                        children: [
                          QButton(
                            icon: (song["isPlaying"] as bool)
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: bs.sm,
                            onPressed: () {
                              for (var s in songs) {
                                s["isPlaying"] = false;
                                s["status"] = "Stopped";
                              }
                              if (!(song["isPlaying"] as bool)) {
                                song["isPlaying"] = true;
                                song["isPaused"] = false;
                                song["status"] = "Playing";
                              }
                              setState(() {});
                            },
                          ),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
