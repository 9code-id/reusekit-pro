import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlaylist9View extends StatefulWidget {
  @override
  State<GrlPlaylist9View> createState() => _GrlPlaylist9ViewState();
}

class _GrlPlaylist9ViewState extends State<GrlPlaylist9View> {
  String searchQuery = "";
  String selectedTimeRange = "This Week";
  String selectedGenre = "All Genres";
  
  List<String> timeRanges = ["Today", "This Week", "This Month", "All Time"];
  List<String> genres = ["All Genres", "Pop", "Rock", "Hip Hop", "Electronic", "Jazz", "Classical"];
  
  List<Map<String, dynamic>> topTracks = [
    {
      "rank": 1,
      "title": "As It Was",
      "artist": "Harry Styles",
      "album": "Harry's House",
      "cover": "https://picsum.photos/60/60?random=1&keyword=music",
      "duration": "2:47",
      "streams": 1850000000,
      "peakPosition": 1,
      "weeksOnChart": 28,
      "changeFromLastWeek": 0,
      "genre": "Pop",
    },
    {
      "rank": 2,
      "title": "Heat Waves",
      "artist": "Glass Animals",
      "album": "Dreamland",
      "cover": "https://picsum.photos/60/60?random=2&keyword=music",
      "duration": "3:58",
      "streams": 1720000000,
      "peakPosition": 1,
      "weeksOnChart": 56,
      "changeFromLastWeek": 1,
      "genre": "Rock",
    },
    {
      "rank": 3,
      "title": "Stay",
      "artist": "The Kid LAROI & Justin Bieber",
      "album": "F*CK LOVE 3: OVER YOU",
      "cover": "https://picsum.photos/60/60?random=3&keyword=music",
      "duration": "2:21",
      "streams": 1650000000,
      "peakPosition": 1,
      "weeksOnChart": 42,
      "changeFromLastWeek": -1,
      "genre": "Pop",
    },
    {
      "rank": 4,
      "title": "Bad Habit",
      "artist": "Steve Lacy",
      "album": "Gemini Rights",
      "cover": "https://picsum.photos/60/60?random=4&keyword=music",
      "duration": "3:51",
      "streams": 1580000000,
      "peakPosition": 1,
      "weeksOnChart": 35,
      "changeFromLastWeek": 2,
      "genre": "Hip Hop",
    },
    {
      "rank": 5,
      "title": "About Damn Time",
      "artist": "Lizzo",
      "album": "Special",
      "cover": "https://picsum.photos/60/60?random=5&keyword=music",
      "duration": "3:12",
      "streams": 1420000000,
      "peakPosition": 1,
      "weeksOnChart": 32,
      "changeFromLastWeek": -1,
      "genre": "Pop",
    },
    {
      "rank": 6,
      "title": "Running Up That Hill",
      "artist": "Kate Bush",
      "album": "Hounds of Love",
      "cover": "https://picsum.photos/60/60?random=6&keyword=music",
      "duration": "4:58",
      "streams": 1380000000,
      "peakPosition": 3,
      "weeksOnChart": 24,
      "changeFromLastWeek": 5,
      "genre": "Rock",
    },
    {
      "rank": 7,
      "title": "Unholy",
      "artist": "Sam Smith ft. Kim Petras",
      "album": "Gloria",
      "cover": "https://picsum.photos/60/60?random=7&keyword=music",
      "duration": "2:36",
      "streams": 1250000000,
      "peakPosition": 1,
      "weeksOnChart": 18,
      "changeFromLastWeek": 0,
      "genre": "Electronic",
    },
    {
      "rank": 8,
      "title": "Anti-Hero",
      "artist": "Taylor Swift",
      "album": "Midnights",
      "cover": "https://picsum.photos/60/60?random=8&keyword=music",
      "duration": "3:20",
      "streams": 1180000000,
      "peakPosition": 1,
      "weeksOnChart": 15,
      "changeFromLastWeek": 3,
      "genre": "Pop",
    },
  ];

  List<Map<String, dynamic>> get filteredTracks {
    List<Map<String, dynamic>> filtered = topTracks;
    
    if (selectedGenre != "All Genres") {
      filtered = filtered.where((track) => track["genre"] == selectedGenre).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((track) {
        return (track["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (track["artist"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Charts"),
        actions: [
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Global Music Charts",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Most streamed songs worldwide",
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
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${filteredTracks.length}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Top Tracks",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${((filteredTracks.fold(0, (sum, track) => sum + (track["streams"] as int))) / 1000000000).toStringAsFixed(1)}B",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Total Streams",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedTimeRange,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Time Period",
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
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Range",
                    items: timeRanges.map((range) => {
                      "label": range,
                      "value": range,
                    }).toList(),
                    value: selectedTimeRange,
                    onChanged: (value, label) {
                      selectedTimeRange = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Genre",
                    items: genres.map((genre) => {
                      "label": genre,
                      "value": genre,
                    }).toList(),
                    value: selectedGenre,
                    onChanged: (value, label) {
                      selectedGenre = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search charts...",
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
            
            // Charts Legend
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Chart movements:",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Icon(Icons.arrow_upward, color: successColor, size: 12),
                  Text(" Up", style: TextStyle(fontSize: 10, color: successColor)),
                  SizedBox(width: spXs),
                  Icon(Icons.arrow_downward, color: dangerColor, size: 12),
                  Text(" Down", style: TextStyle(fontSize: 10, color: dangerColor)),
                  SizedBox(width: spXs),
                  Icon(Icons.remove, color: disabledBoldColor, size: 12),
                  Text(" Same", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Charts List
            Column(
              spacing: spXs,
              children: filteredTracks.map((track) {
                bool isTopThree = (track["rank"] as int) <= 3;
                Color rankColor = isTopThree ? warningColor : primaryColor;
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isTopThree ? warningColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: isTopThree ? Border.all(color: warningColor.withAlpha(100), width: 1) : null,
                  ),
                  child: Row(
                    children: [
                      // Rank
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: rankColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Text(
                            "${track["rank"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: spMd),
                      
                      // Cover Art
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusXs),
                          image: DecorationImage(
                            image: NetworkImage("${track["cover"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            if (isTopThree)
                              Positioned(
                                top: 2,
                                right: 2,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: warningColor,
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
                      
                      // Track Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${track["title"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fsH6,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${track["artist"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
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
                                    color: infoColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${track["genre"]}",
                                    style: TextStyle(
                                      color: infoColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${track["weeksOnChart"]} weeks",
                                  style: TextStyle(
                                    color: disabledColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${((track["streams"] as int) / 1000000).toStringAsFixed(0)}M streams",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Chart Movement & Actions
                      Column(
                        children: [
                          // Chart movement
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (track["changeFromLastWeek"] as int) > 0 ? successColor.withAlpha(30) :
                                     (track["changeFromLastWeek"] as int) < 0 ? dangerColor.withAlpha(30) :
                                     disabledColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  (track["changeFromLastWeek"] as int) > 0 ? Icons.arrow_upward :
                                  (track["changeFromLastWeek"] as int) < 0 ? Icons.arrow_downward :
                                  Icons.remove,
                                  size: 12,
                                  color: (track["changeFromLastWeek"] as int) > 0 ? successColor :
                                         (track["changeFromLastWeek"] as int) < 0 ? dangerColor :
                                         disabledBoldColor,
                                ),
                                if ((track["changeFromLastWeek"] as int) != 0)
                                  Text(
                                    "${(track["changeFromLastWeek"] as int).abs()}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: (track["changeFromLastWeek"] as int) > 0 ? successColor :
                                             dangerColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Peak: #${track["peakPosition"]}",
                            style: TextStyle(
                              color: disabledColor,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${track["duration"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.play_circle_outline,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spXs),
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
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Load More Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Load More Charts",
                icon: Icons.expand_more,
                size: bs.sm,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
