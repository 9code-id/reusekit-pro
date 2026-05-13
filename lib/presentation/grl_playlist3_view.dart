import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlaylist3View extends StatefulWidget {
  @override
  State<GrlPlaylist3View> createState() => _GrlPlaylist3ViewState();
}

class _GrlPlaylist3ViewState extends State<GrlPlaylist3View> {
  String selectedFilter = "All";
  String searchQuery = "";
  bool isShuffled = false;
  
  final List<Map<String, dynamic>> playlists = [
    {
      "title": "Chill Vibes",
      "description": "Perfect for relaxing and unwinding",
      "trackCount": 45,
      "duration": "2h 34m",
      "cover": "https://picsum.photos/300/300?random=1&keyword=chill",
      "creator": "You",
      "isPublic": true,
      "lastUpdated": "2 days ago",
      "mood": "Relaxing",
      "genre": "Lo-fi",
    },
    {
      "title": "Workout Beats",
      "description": "High energy tracks for your gym sessions",
      "trackCount": 32,
      "duration": "1h 48m",
      "cover": "https://picsum.photos/300/300?random=2&keyword=workout",
      "creator": "You",
      "isPublic": false,
      "lastUpdated": "1 week ago",
      "mood": "Energetic",
      "genre": "Electronic",
    },
    {
      "title": "Study Focus",
      "description": "Instrumental music for concentration",
      "trackCount": 28,
      "duration": "1h 56m",
      "cover": "https://picsum.photos/300/300?random=3&keyword=study",
      "creator": "Study Music Co.",
      "isPublic": true,
      "lastUpdated": "3 days ago",
      "mood": "Focused",
      "genre": "Instrumental",
    },
    {
      "title": "Road Trip Classics",
      "description": "Best songs for long drives",
      "trackCount": 67,
      "duration": "4h 12m",
      "cover": "https://picsum.photos/300/300?random=4&keyword=road",
      "creator": "Music Lover",
      "isPublic": true,
      "lastUpdated": "5 days ago",
      "mood": "Adventure",
      "genre": "Rock",
    },
    {
      "title": "Late Night Jazz",
      "description": "Smooth jazz for evening moods",
      "trackCount": 23,
      "duration": "1h 34m",
      "cover": "https://picsum.photos/300/300?random=5&keyword=jazz",
      "creator": "Jazz Collection",
      "isPublic": true,
      "lastUpdated": "1 day ago",
      "mood": "Calm",
      "genre": "Jazz",
    },
    {
      "title": "Party Mix 2024",
      "description": "Latest hits for your party",
      "trackCount": 54,
      "duration": "3h 21m",
      "cover": "https://picsum.photos/300/300?random=6&keyword=party",
      "creator": "DJ Mixer",
      "isPublic": true,
      "lastUpdated": "Yesterday",
      "mood": "Party",
      "genre": "Pop",
    },
  ];

  final List<String> filters = ["All", "Your Playlists", "Following", "Recently Played"];
  final List<String> moods = ["All", "Relaxing", "Energetic", "Focused", "Adventure", "Calm", "Party"];

  List<Map<String, dynamic>> get filteredPlaylists {
    var filtered = playlists.where((playlist) {
      bool matchesSearch = searchQuery.isEmpty ||
          (playlist["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (playlist["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "All" ||
          (selectedFilter == "Your Playlists" && playlist["creator"] == "You") ||
          (selectedFilter == "Following" && playlist["creator"] != "You") ||
          (selectedFilter == "Recently Played");
      
      return matchesSearch && matchesFilter;
    }).toList();

    if (isShuffled) {
      filtered.shuffle();
    }
    
    return filtered;
  }

  void _toggleShuffle() {
    isShuffled = !isShuffled;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + spSm,
              left: spMd,
              right: spMd,
              bottom: spSm,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primaryColor.withAlpha(20),
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => back(),
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Your Playlists",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: _toggleShuffle,
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isShuffled ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor,
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.shuffle,
                          color: isShuffled ? Colors.white : primaryColor,
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
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
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
                      Container(
                        padding: EdgeInsets.all(spSm),
                        child: Icon(
                          Icons.search,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Filter Tabs
          Container(
            padding: EdgeInsets.symmetric(vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowXs],
            ),
            child: QHorizontalScroll(
              children: filters.map((filter) {
                bool isSelected = selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    selectedFilter = filter;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: spXs),
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Stats Summary
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(10)],
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredPlaylists.length}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Playlists",
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
                      gradient: LinearGradient(
                        colors: [successColor.withAlpha(20), successColor.withAlpha(10)],
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredPlaylists.fold(0, (sum, playlist) => sum + (playlist["trackCount"] as int))}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Total Songs",
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
          ),

          // Playlists Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: ResponsiveGridView(
                minItemWidth: 200,
                children: filteredPlaylists.map((playlist) {
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
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusLg),
                                  topRight: Radius.circular(radiusLg),
                                ),
                                child: Image.network(
                                  "${playlist["cover"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(120),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  playlist["isPublic"] as bool 
                                      ? Icons.public 
                                      : Icons.lock,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
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

                        // Playlist Info
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${playlist["title"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
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
                              
                              // Stats Row
                              Row(
                                children: [
                                  Icon(
                                    Icons.queue_music,
                                    color: disabledBoldColor,
                                    size: 14,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${playlist["trackCount"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.access_time,
                                    color: disabledBoldColor,
                                    size: 14,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${playlist["duration"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              
                              // Creator and Genre
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "by ${playlist["creator"]}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${playlist["genre"]}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              
                              // Mood Tag
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      _getMoodColor(playlist["mood"] as String).withAlpha(40),
                                      _getMoodColor(playlist["mood"] as String).withAlpha(20),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getMoodIcon(playlist["mood"] as String),
                                      color: _getMoodColor(playlist["mood"] as String),
                                      size: 12,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${playlist["mood"]}",
                                      style: TextStyle(
                                        color: _getMoodColor(playlist["mood"] as String),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: spSm),
                              
                              // Last Updated
                              Text(
                                "Updated ${playlist["lastUpdated"]}",
                                style: TextStyle(
                                  color: disabledColor,
                                  fontSize: 10,
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
            ),
          ),
        ],
      ),
    );
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case "Relaxing":
        return Colors.blue;
      case "Energetic":
        return Colors.orange;
      case "Focused":
        return Colors.purple;
      case "Adventure":
        return Colors.green;
      case "Calm":
        return Colors.teal;
      case "Party":
        return Colors.pink;
      default:
        return primaryColor;
    }
  }

  IconData _getMoodIcon(String mood) {
    switch (mood) {
      case "Relaxing":
        return Icons.spa;
      case "Energetic":
        return Icons.bolt;
      case "Focused":
        return Icons.psychology;
      case "Adventure":
        return Icons.explore;
      case "Calm":
        return Icons.self_improvement;
      case "Party":
        return Icons.celebration;
      default:
        return Icons.music_note;
    }
  }
}
