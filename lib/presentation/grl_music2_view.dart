import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMusic2View extends StatefulWidget {
  @override
  State<GrlMusic2View> createState() => _GrlMusic2ViewState();
}

class _GrlMusic2ViewState extends State<GrlMusic2View> {
  int currentTab = 0;
  String searchQuery = "";

  List<Map<String, dynamic>> genres = [
    {"name": "Pop", "color": warningColor, "count": 1250},
    {"name": "Rock", "color": dangerColor, "count": 890},
    {"name": "Hip Hop", "color": primaryColor, "count": 1450},
    {"name": "Electronic", "color": infoColor, "count": 720},
    {"name": "Jazz", "color": successColor, "count": 430},
    {"name": "Classical", "color": primaryColor, "count": 320},
  ];

  List<Map<String, dynamic>> featuredPlaylists = [
    {
      "title": "Today's Top Hits",
      "description": "The biggest songs of the day",
      "image": "https://picsum.photos/150/150?random=1&keyword=playlist",
      "songCount": 50,
      "followers": "2.1M",
      "isFollowing": true,
    },
    {
      "title": "RapCaviar",
      "description": "The biggest tracks in hip-hop",
      "image": "https://picsum.photos/150/150?random=2&keyword=hiphop",
      "songCount": 65,
      "followers": "1.8M",
      "isFollowing": false,
    },
    {
      "title": "Rock Classics",
      "description": "Rock legends & epic songs",
      "image": "https://picsum.photos/150/150?random=3&keyword=rock",
      "songCount": 100,
      "followers": "980K",
      "isFollowing": true,
    },
    {
      "title": "Chill Hits",
      "description": "Kick back to the best new and recent songs",
      "image": "https://picsum.photos/150/150?random=4&keyword=chill",
      "songCount": 45,
      "followers": "1.2M",
      "isFollowing": false,
    },
  ];

  List<Map<String, dynamic>> newReleases = [
    {
      "title": "Midnight",
      "artist": "Taylor Swift",
      "type": "Album",
      "releaseDate": "October 21, 2022",
      "image": "https://picsum.photos/120/120?random=5&keyword=album",
      "isNew": true,
    },
    {
      "title": "Harry's House",
      "artist": "Harry Styles",
      "type": "Album",
      "releaseDate": "May 20, 2022",
      "image": "https://picsum.photos/120/120?random=6&keyword=album",
      "isNew": false,
    },
    {
      "title": "Special",
      "artist": "Lizzo",
      "type": "Album",
      "releaseDate": "July 15, 2022",
      "image": "https://picsum.photos/120/120?random=7&keyword=album",
      "isNew": false,
    },
    {
      "title": "Renaissance",
      "artist": "Beyoncé",
      "type": "Album",
      "releaseDate": "July 29, 2022",
      "image": "https://picsum.photos/120/120?random=8&keyword=album",
      "isNew": true,
    },
  ];

  List<Map<String, dynamic>> topArtists = [
    {
      "name": "Taylor Swift",
      "followers": "88.2M",
      "image": "https://picsum.photos/100/100?random=9&keyword=artist",
      "isFollowing": true,
      "monthlyListeners": "94.5M",
    },
    {
      "name": "Bad Bunny",
      "followers": "65.1M",
      "image": "https://picsum.photos/100/100?random=10&keyword=artist",
      "isFollowing": false,
      "monthlyListeners": "87.2M",
    },
    {
      "name": "The Weeknd",
      "followers": "71.8M",
      "image": "https://picsum.photos/100/100?random=11&keyword=artist",
      "isFollowing": true,
      "monthlyListeners": "78.9M",
    },
    {
      "name": "Ariana Grande",
      "followers": "67.4M",
      "image": "https://picsum.photos/100/100?random=12&keyword=artist",
      "isFollowing": false,
      "monthlyListeners": "65.3M",
    },
    {
      "name": "Drake",
      "followers": "63.2M",
      "image": "https://picsum.photos/100/100?random=13&keyword=artist",
      "isFollowing": true,
      "monthlyListeners": "72.1M",
    },
  ];

  List<Map<String, dynamic>> trendingSongs = [
    {
      "title": "Anti-Hero",
      "artist": "Taylor Swift",
      "album": "Midnights",
      "duration": "3:20",
      "image": "https://picsum.photos/60/60?random=14&keyword=song",
      "rank": 1,
      "movement": "up",
    },
    {
      "title": "Unholy",
      "artist": "Sam Smith ft. Kim Petras",
      "album": "Single",
      "duration": "2:36",
      "image": "https://picsum.photos/60/60?random=15&keyword=song",
      "rank": 2,
      "movement": "new",
    },
    {
      "title": "As It Was",
      "artist": "Harry Styles",
      "album": "Harry's House",
      "duration": "2:47",
      "image": "https://picsum.photos/60/60?random=16&keyword=song",
      "rank": 3,
      "movement": "down",
    },
    {
      "title": "About Damn Time",
      "artist": "Lizzo",
      "album": "Special",
      "duration": "3:12",
      "image": "https://picsum.photos/60/60?random=17&keyword=song",
      "rank": 4,
      "movement": "up",
    },
    {
      "title": "Heat Waves",
      "artist": "Glass Animals",
      "album": "Dreamland",
      "duration": "3:58",
      "image": "https://picsum.photos/60/60?random=18&keyword=song",
      "rank": 5,
      "movement": "same",
    },
  ];

  Color _getMovementColor(String movement) {
    switch (movement) {
      case 'up':
        return successColor;
      case 'down':
        return dangerColor;
      case 'new':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getMovementIcon(String movement) {
    switch (movement) {
      case 'up':
        return Icons.trending_up;
      case 'down':
        return Icons.trending_down;
      case 'new':
        return Icons.fiber_new;
      default:
        return Icons.trending_flat;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Discover Music",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Explore", icon: Icon(Icons.explore)),
        Tab(text: "Charts", icon: Icon(Icons.trending_up)),
        Tab(text: "New", icon: Icon(Icons.fiber_new)),
      ],
      tabChildren: [
        // Explore Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spLg,
            children: [
              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search songs, artists, albums...",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              // Genres
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
                children: genres.map((genre) {
                  return Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: (genre["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: (genre["color"] as Color).withAlpha(50),
                        width: 1,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(radiusLg),
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: spXs,
                            children: [
                              Text(
                                "${genre["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: genre["color"] as Color,
                                ),
                              ),
                              Text(
                                "${(genre["count"] as int)} songs",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Featured Playlists
              Text(
                "Featured Playlists",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QHorizontalScroll(
                children: featuredPlaylists.map((playlist) {
                  bool isFollowing = playlist["isFollowing"] as bool;
                  return Container(
                    width: 200,
                    margin: EdgeInsets.only(right: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${playlist["image"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${playlist["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${playlist["description"]}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${playlist["songCount"]} songs • ${playlist["followers"]} followers",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Play",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: isFollowing 
                                    ? successColor.withAlpha(20)
                                    : primaryColor.withAlpha(10),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    playlist["isFollowing"] = !playlist["isFollowing"];
                                  });
                                },
                                icon: Icon(
                                  isFollowing ? Icons.favorite : Icons.favorite_border,
                                  color: isFollowing ? successColor : primaryColor,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Top Artists
              Text(
                "Top Artists",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QHorizontalScroll(
                children: topArtists.map((artist) {
                  bool isFollowing = artist["isFollowing"] as bool;
                  return Container(
                    width: 140,
                    margin: EdgeInsets.only(right: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [shadowSm],
                          ),
                          child: ClipOval(
                            child: Image.network(
                              "${artist["image"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          spacing: spXs,
                          children: [
                            Text(
                              "${artist["name"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${artist["monthlyListeners"]} listeners",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: isFollowing ? "Following" : "Follow",
                            size: bs.sm,
                            onPressed: () {
                              setState(() {
                                artist["isFollowing"] = !artist["isFollowing"];
                              });
                            },
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

        // Charts Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spLg,
            children: [
              // Chart Header
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      warningColor.withAlpha(20),
                      warningColor.withAlpha(5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 40,
                      color: warningColor,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Global Top 50",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "The most played songs on Spotify right now",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Trending Songs",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Column(
                spacing: spSm,
                children: trendingSongs.map((song) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _getMovementColor(song["movement"]).withAlpha(20),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${song["rank"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _getMovementColor(song["movement"]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
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
                                  color: primaryColor,
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
                            Icon(
                              _getMovementIcon(song["movement"]),
                              color: _getMovementColor(song["movement"]),
                              size: 16,
                            ),
                            Text(
                              "${song["duration"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Icon(
                              Icons.play_arrow,
                              color: primaryColor,
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
        ),

        // New Releases Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spLg,
            children: [
              Text(
                "New Releases",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 160,
                children: newReleases.map((release) {
                  bool isNew = release["isNew"] as bool;
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${release["image"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (isNew)
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "NEW",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${release["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${release["artist"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${release["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${release["releaseDate"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Play",
                            size: bs.sm,
                            onPressed: () {},
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
    );
  }
}
