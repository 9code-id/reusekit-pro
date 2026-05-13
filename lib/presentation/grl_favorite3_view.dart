import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFavorite3View extends StatefulWidget {
  @override
  State<GrlFavorite3View> createState() => _GrlFavorite3ViewState();
}

class _GrlFavorite3ViewState extends State<GrlFavorite3View> {
  int currentTab = 0;

  List<Map<String, dynamic>> favoriteVideos = [
    {
      "id": "1",
      "title": "Complete Flutter Tutorial Series",
      "channel": "TechAcademy",
      "duration": "45:30",
      "views": "2.5M",
      "uploadDate": "2024-11-20",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=coding",
      "isLive": false,
      "category": "Technology",
      "description": "Learn Flutter development from basics to advanced concepts"
    },
    {
      "id": "2",
      "title": "Beautiful Nature Documentary",
      "channel": "WildLife Channel",
      "duration": "1:20:15",
      "views": "8.9M",
      "uploadDate": "2024-12-01",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=nature",
      "isLive": false,
      "category": "Documentary",
      "description": "Explore the world's most stunning natural landscapes"
    },
    {
      "id": "3",
      "title": "LIVE: Breaking News Update",
      "channel": "Global News",
      "duration": "LIVE",
      "views": "156K",
      "uploadDate": "2024-12-20",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=news",
      "isLive": true,
      "category": "News",
      "description": "Latest breaking news and current events coverage"
    }
  ];

  List<Map<String, dynamic>> favoritePlaylists = [
    {
      "id": "1",
      "title": "Morning Workout Routine",
      "creator": "FitLife Studio",
      "videoCount": 25,
      "totalDuration": "8 hours",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=fitness",
      "category": "Fitness",
      "description": "Complete morning workout routines for all fitness levels"
    },
    {
      "id": "2",
      "title": "Classic Rock Hits",
      "creator": "Music Central",
      "videoCount": 150,
      "totalDuration": "12 hours",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=music",
      "category": "Music",
      "description": "The greatest rock songs of all time"
    },
    {
      "id": "3",
      "title": "Cooking Masterclass",
      "creator": "Chef's Corner",
      "videoCount": 45,
      "totalDuration": "15 hours",
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=cooking",
      "category": "Food",
      "description": "Professional cooking techniques and recipes"
    }
  ];

  List<Map<String, dynamic>> favoriteChannels = [
    {
      "id": "1",
      "name": "TechReview Pro",
      "subscribers": "5.2M",
      "videos": 1250,
      "avatar": "https://picsum.photos/100/100?random=7&keyword=tech",
      "category": "Technology",
      "isVerified": true,
      "description": "Latest tech reviews and gadget unboxings"
    },
    {
      "id": "2",
      "name": "Travel Adventures",
      "subscribers": "3.8M",
      "videos": 890,
      "avatar": "https://picsum.photos/100/100?random=8&keyword=travel",
      "category": "Travel",
      "isVerified": true,
      "description": "Explore amazing destinations around the world"
    },
    {
      "id": "3",
      "name": "Comedy Central Hub",
      "subscribers": "12.5M",
      "videos": 2340,
      "avatar": "https://picsum.photos/100/100?random=9&keyword=comedy",
      "category": "Entertainment",
      "isVerified": true,
      "description": "Hilarious comedy skits and stand-up performances"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Favorite Media",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Videos", icon: Icon(Icons.play_arrow)),
        Tab(text: "Playlists", icon: Icon(Icons.playlist_play)),
        Tab(text: "Channels", icon: Icon(Icons.subscriptions)),
      ],
      tabChildren: [
        _buildVideosTab(),
        _buildPlaylistsTab(),
        _buildChannelsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildVideosTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${favoriteVideos.length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Saved Videos",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${favoriteVideos.where((v) => v["isLive"] as bool).length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Live Videos",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${favoriteVideos.map((v) => v["views"] as String).map((v) => v.contains("M") ? double.parse(v.replaceAll("M", "")) : double.parse(v.replaceAll("K", "")) / 1000).fold(0.0, (sum, views) => sum + views).toStringAsFixed(1)}M",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Views",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          favoriteVideos.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(height: spXl),
                      Icon(
                        Icons.video_library,
                        size: 64,
                        color: disabledColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "No favorite videos",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      QButton(
                        label: "Browse Videos",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: favoriteVideos.length,
                  separatorBuilder: (context, index) => SizedBox(height: spMd),
                  itemBuilder: (context, index) {
                    final video = favoriteVideos[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Video Thumbnail
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(radiusLg),
                                ),
                                child: Image.network(
                                  "${video["thumbnail"]}",
                                  width: 120,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: spXs,
                                right: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(200),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${video["duration"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              if (video["isLive"] as bool)
                                Positioned(
                                  top: spXs,
                                  left: spXs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "LIVE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          // Video Details
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${video["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${video["channel"]}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${video["views"]} views",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(" • ", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                                      Text(
                                        "${video["uploadDate"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
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
                                          "${video["category"]}",
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () async {
                                          bool isConfirmed = await confirm("Remove this video from favorites?");
                                          if (isConfirmed) {
                                            favoriteVideos.removeWhere((v) => v["id"] == video["id"]);
                                            setState(() {});
                                            ss("Video removed from favorites");
                                          }
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color: dangerColor,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildPlaylistsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${favoritePlaylists.length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Playlists",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${favoritePlaylists.fold(0, (sum, playlist) => sum + (playlist["videoCount"] as int))}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Videos",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "35 hrs",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Watch Time",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          favoritePlaylists.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(height: spXl),
                      Icon(
                        Icons.playlist_play,
                        size: 64,
                        color: disabledColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "No favorite playlists",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      QButton(
                        label: "Browse Playlists",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              : ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: favoritePlaylists.map((playlist) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(radiusLg),
                                ),
                                child: Image.network(
                                  "${playlist["thumbnail"]}",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: GestureDetector(
                                  onTap: () async {
                                    bool isConfirmed = await confirm("Remove this playlist from favorites?");
                                    if (isConfirmed) {
                                      favoritePlaylists.removeWhere((p) => p["id"] == playlist["id"]);
                                      setState(() {});
                                      ss("Playlist removed from favorites");
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [shadowSm],
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: dangerColor,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: spSm,
                                right: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(200),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.playlist_play,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${playlist["videoCount"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${playlist["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "by ${playlist["creator"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: disabledBoldColor,
                                      size: 14,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${playlist["totalDuration"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spSm),
                                Container(
                                  width: double.infinity,
                                  child: QButton(
                                    label: "Play All",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Playing playlist: ${playlist["title"]}");
                                    },
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
    );
  }

  Widget _buildChannelsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${favoriteChannels.length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Subscriptions",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${(favoriteChannels.fold(0.0, (sum, channel) => sum + double.parse((channel["subscribers"] as String).replaceAll("M", ""))).toStringAsFixed(1))}M",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Subscribers",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${favoriteChannels.fold(0, (sum, channel) => sum + (channel["videos"] as int))}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Total Videos",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          favoriteChannels.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(height: spXl),
                      Icon(
                        Icons.subscriptions,
                        size: 64,
                        color: disabledColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "No favorite channels",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      QButton(
                        label: "Discover Channels",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: favoriteChannels.length,
                  separatorBuilder: (context, index) => SizedBox(height: spMd),
                  itemBuilder: (context, index) {
                    final channel = favoriteChannels[index];
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusXl),
                                child: Image.network(
                                  "${channel["avatar"]}",
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (channel["isVerified"] as bool)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
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
                              children: [
                                Text(
                                  "${channel["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${channel["subscribers"]} subscribers • ${channel["videos"]} videos",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${channel["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              QButton(
                                label: "Visit",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Visiting ${channel["name"]}");
                                },
                              ),
                              SizedBox(height: spSm),
                              GestureDetector(
                                onTap: () async {
                                  bool isConfirmed = await confirm("Unsubscribe from ${channel["name"]}?");
                                  if (isConfirmed) {
                                    favoriteChannels.removeWhere((c) => c["id"] == channel["id"]);
                                    setState(() {});
                                    ss("Unsubscribed from ${channel["name"]}");
                                  }
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: dangerColor,
                                  size: 20,
                                ),
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
    );
  }
}
