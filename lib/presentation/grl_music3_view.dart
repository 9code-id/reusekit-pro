import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMusic3View extends StatefulWidget {
  @override
  State<GrlMusic3View> createState() => _GrlMusic3ViewState();
}

class _GrlMusic3ViewState extends State<GrlMusic3View> {
  int currentTab = 0;

  List<Map<String, dynamic>> userPlaylists = [
    {
      "title": "My Favorites",
      "description": "Songs I love the most",
      "songCount": 47,
      "image": "https://picsum.photos/120/120?random=1&keyword=favorites",
      "isOwner": true,
      "isPrivate": false,
      "lastPlayed": "2 hours ago",
      "totalDuration": "3h 24m",
    },
    {
      "title": "Workout Mix",
      "description": "High energy songs for gym",
      "songCount": 32,
      "image": "https://picsum.photos/120/120?random=2&keyword=workout",
      "isOwner": true,
      "isPrivate": false,
      "lastPlayed": "Yesterday",
      "totalDuration": "2h 15m",
    },
    {
      "title": "Chill Vibes",
      "description": "Relaxing music for lazy days",
      "songCount": 28,
      "image": "https://picsum.photos/120/120?random=3&keyword=chill",
      "isOwner": true,
      "isPrivate": true,
      "lastPlayed": "3 days ago",
      "totalDuration": "1h 52m",
    },
    {
      "title": "Road Trip",
      "description": "Perfect songs for long drives",
      "songCount": 55,
      "image": "https://picsum.photos/120/120?random=4&keyword=road",
      "isOwner": true,
      "isPrivate": false,
      "lastPlayed": "1 week ago",
      "totalDuration": "4h 8m",
    },
  ];

  List<Map<String, dynamic>> followedPlaylists = [
    {
      "title": "Today's Top Hits",
      "creator": "Spotify",
      "followers": "28.2M",
      "image": "https://picsum.photos/120/120?random=5&keyword=hits",
      "isFollowing": true,
      "isOfficial": true,
    },
    {
      "title": "RapCaviar",
      "creator": "Spotify",
      "followers": "15.8M",
      "image": "https://picsum.photos/120/120?random=6&keyword=rap",
      "isFollowing": true,
      "isOfficial": true,
    },
    {
      "title": "Indie Rock Mix",
      "creator": "John Doe",
      "followers": "1.2K",
      "image": "https://picsum.photos/120/120?random=7&keyword=indie",
      "isFollowing": true,
      "isOfficial": false,
    },
    {
      "title": "Jazz Essentials",
      "creator": "Music Lover",
      "followers": "892",
      "image": "https://picsum.photos/120/120?random=8&keyword=jazz",
      "isFollowing": true,
      "isOfficial": false,
    },
  ];

  List<Map<String, dynamic>> recentlyPlayed = [
    {
      "title": "Midnight Rain",
      "artist": "Taylor Swift",
      "album": "Midnights",
      "image": "https://picsum.photos/60/60?random=9&keyword=song",
      "playedAt": "5 minutes ago",
      "duration": "2:54",
    },
    {
      "title": "Anti-Hero",
      "artist": "Taylor Swift",
      "album": "Midnights",
      "image": "https://picsum.photos/60/60?random=10&keyword=song",
      "playedAt": "12 minutes ago",
      "duration": "3:20",
    },
    {
      "title": "Lavender Haze",
      "artist": "Taylor Swift",
      "album": "Midnights",
      "image": "https://picsum.photos/60/60?random=11&keyword=song",
      "playedAt": "18 minutes ago",
      "duration": "3:22",
    },
    {
      "title": "As It Was",
      "artist": "Harry Styles",
      "album": "Harry's House",
      "image": "https://picsum.photos/60/60?random=12&keyword=song",
      "playedAt": "1 hour ago",
      "duration": "2:47",
    },
    {
      "title": "About Damn Time",
      "artist": "Lizzo",
      "album": "Special",
      "image": "https://picsum.photos/60/60?random=13&keyword=song",
      "playedAt": "2 hours ago",
      "duration": "3:12",
    },
  ];

  List<Map<String, dynamic>> favoriteArtists = [
    {
      "name": "Taylor Swift",
      "image": "https://picsum.photos/80/80?random=14&keyword=artist",
      "followers": "88.2M",
      "isFollowing": true,
    },
    {
      "name": "Harry Styles",
      "image": "https://picsum.photos/80/80?random=15&keyword=artist",
      "followers": "67.4M",
      "isFollowing": true,
    },
    {
      "name": "The Weeknd",
      "image": "https://picsum.photos/80/80?random=16&keyword=artist",
      "followers": "71.8M",
      "isFollowing": true,
    },
    {
      "name": "Ariana Grande",
      "image": "https://picsum.photos/80/80?random=17&keyword=artist",
      "followers": "67.1M",
      "isFollowing": true,
    },
    {
      "name": "Ed Sheeran",
      "image": "https://picsum.photos/80/80?random=18&keyword=artist",
      "followers": "54.8M",
      "isFollowing": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Your Library",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Playlists", icon: Icon(Icons.queue_music)),
        Tab(text: "Recent", icon: Icon(Icons.history)),
        Tab(text: "Artists", icon: Icon(Icons.person)),
      ],
      tabChildren: [
        // Playlists Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spLg,
            children: [
              // Create Playlist Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create New Playlist",
                  size: bs.md,
                  icon: Icons.add,
                  onPressed: () {},
                ),
              ),

              // Your Playlists
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Created by You",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "See All",
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
                spacing: spMd,
                children: userPlaylists.map((playlist) {
                  bool isPrivate = playlist["isPrivate"] as bool;
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
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
                            if (isPrivate)
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${playlist["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${playlist["description"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${playlist["songCount"]} songs • ${playlist["totalDuration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Last played ${playlist["lastPlayed"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          spacing: spSm,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(50),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.more_vert,
                                  color: disabledBoldColor,
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

              // Followed Playlists
              Text(
                "Following",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Column(
                spacing: spSm,
                children: followedPlaylists.map((playlist) {
                  bool isOfficial = playlist["isOfficial"] as bool;
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
                          width: 60,
                          height: 60,
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
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${playlist["title"]}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (isOfficial)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "OFFICIAL",
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: successColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Text(
                                "by ${playlist["creator"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${playlist["followers"]} followers",
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
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: successColor,
                                size: 16,
                              ),
                            ),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 16,
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
        ),

        // Recent Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spLg,
            children: [
              // Quick Actions
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: primaryColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        spacing: spSm,
                        children: [
                          Icon(
                            Icons.history,
                            color: primaryColor,
                            size: 20,
                          ),
                          Text(
                            "Clear History",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
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
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: successColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        spacing: spSm,
                        children: [
                          Icon(
                            Icons.shuffle,
                            color: successColor,
                            size: 20,
                          ),
                          Text(
                            "Shuffle All",
                            style: TextStyle(
                              fontSize: 14,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Text(
                "Recently Played",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Column(
                spacing: spSm,
                children: recentlyPlayed.map((song) {
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
                              Text(
                                "Played ${song["playedAt"]}",
                                style: TextStyle(
                                  fontSize: 11,
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
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(10),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: primaryColor,
                                  size: 16,
                                ),
                              ),
                            ),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(50),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.more_vert,
                                  color: disabledBoldColor,
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
            ],
          ),
        ),

        // Artists Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spLg,
            children: [
              Text(
                "Your Favorite Artists",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: favoriteArtists.map((artist) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spMd,
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
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${artist["followers"]} followers",
                              style: TextStyle(
                                fontSize: 12,
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
                                color: successColor.withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite,
                                  color: successColor,
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
            ],
          ),
        ),
      ],
    );
  }
}
