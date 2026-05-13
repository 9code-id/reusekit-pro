import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlaylist1View extends StatefulWidget {
  @override
  State<GrlPlaylist1View> createState() => _GrlPlaylist1ViewState();
}

class _GrlPlaylist1ViewState extends State<GrlPlaylist1View> {
  bool isPlaying = false;
  bool isShuffled = false;
  bool isFollowing = false;
  int selectedFilter = 0;

  Map<String, dynamic> playlistInfo = {
    "name": "Summer Vibes 2024",
    "description": "The perfect soundtrack for your summer adventures. Featuring the latest hits and timeless classics.",
    "artwork": "https://picsum.photos/300/300?random=70&keyword=summer",
    "owner": "Spotify",
    "followers": 2847392,
    "tracks": 127,
    "duration": "8h 23m",
    "isPublic": true,
    "lastUpdated": "3 days ago",
  };

  List<String> filterOptions = ["All", "Recently Added", "Downloaded", "Liked"];

  List<Map<String, dynamic>> tracks = [
    {
      "title": "Blinding Lights",
      "artist": "The Weeknd",
      "album": "After Hours",
      "duration": "3:20",
      "isPlaying": false,
      "isLiked": true,
      "isDownloaded": true,
      "artwork": "https://picsum.photos/60/60?random=71&keyword=lights",
      "addedDate": "2024-06-15",
      "plays": 1247892,
    },
    {
      "title": "Levitating",
      "artist": "Dua Lipa",
      "album": "Future Nostalgia",
      "duration": "3:23",
      "isPlaying": true,
      "isLiked": false,
      "isDownloaded": true,
      "artwork": "https://picsum.photos/60/60?random=72&keyword=levitate",
      "addedDate": "2024-06-14",
      "plays": 987234,
    },
    {
      "title": "Good 4 U",
      "artist": "Olivia Rodrigo",
      "album": "SOUR",
      "duration": "2:58",
      "isPlaying": false,
      "isLiked": true,
      "isDownloaded": false,
      "artwork": "https://picsum.photos/60/60?random=73&keyword=good",
      "addedDate": "2024-06-13",
      "plays": 2156789,
    },
    {
      "title": "Stay",
      "artist": "The Kid LAROI, Justin Bieber",
      "album": "F*CK LOVE 3+",
      "duration": "2:21",
      "isPlaying": false,
      "isLiked": false,
      "isDownloaded": true,
      "artwork": "https://picsum.photos/60/60?random=74&keyword=stay",
      "addedDate": "2024-06-12",
      "plays": 1678923,
    },
    {
      "title": "Anti-Hero",
      "artist": "Taylor Swift",
      "album": "Midnights",
      "duration": "3:20",
      "isPlaying": false,
      "isLiked": true,
      "isDownloaded": false,
      "artwork": "https://picsum.photos/60/60?random=75&keyword=hero",
      "addedDate": "2024-06-11",
      "plays": 3247891,
    },
  ];

  List<Map<String, dynamic>> get filteredTracks {
    switch (selectedFilter) {
      case 1: // Recently Added
        return tracks.where((track) {
          DateTime addedDate = DateTime.parse(track["addedDate"]);
          return DateTime.now().difference(addedDate).inDays <= 7;
        }).toList();
      case 2: // Downloaded
        return tracks.where((track) => track["isDownloaded"] as bool).toList();
      case 3: // Liked
        return tracks.where((track) => track["isLiked"] as bool).toList();
      default:
        return tracks;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildPlaylistInfo(),
                  _buildActionButtons(),
                  _buildFilterSection(),
                  _buildTracksList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(spMd, MediaQuery.of(context).padding.top + spSm, spMd, spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF4CAF50),
            Color(0xFF388E3C),
          ],
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => back(),
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Playlist",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF388E3C),
            Color(0xFF2E7D32),
            Colors.black,
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(128),
                  blurRadius: 25,
                  offset: Offset(0, 15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${playlistInfo["artwork"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "${playlistInfo["name"]}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: spSm),
          Text(
            "${playlistInfo["description"]}",
            style: TextStyle(
              color: Colors.white.withAlpha(179),
              fontSize: 14,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Made by ${playlistInfo["owner"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(179),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${((playlistInfo["followers"] as int) / 1000000).toStringAsFixed(1)}M followers",
                style: TextStyle(
                  color: Colors.white.withAlpha(179),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${playlistInfo["tracks"]} tracks • ${playlistInfo["duration"]}",
            style: TextStyle(
              color: Colors.white.withAlpha(179),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              isFollowing = !isFollowing;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: isFollowing ? Colors.transparent : Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: isFollowing ? Border.all(color: Colors.white, width: 1) : null,
              ),
              child: Text(
                isFollowing ? "Following" : "Follow",
                style: TextStyle(
                  color: isFollowing ? Colors.white : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: spMd),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 28,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              isShuffled = !isShuffled;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isShuffled ? Color(0xFF4CAF50).withAlpha(51) : Colors.white.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.shuffle,
                color: isShuffled ? Color(0xFF4CAF50) : Colors.white,
                size: 24,
              ),
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {
              isPlaying = !isPlaying;
              setState(() {});
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF4CAF50).withAlpha(77),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      child: Row(
        children: [
          Text(
            "Recently played",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          QHorizontalScroll(
            children: List.generate(filterOptions.length, (index) {
              bool isSelected = selectedFilter == index;
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedFilter = index;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF4CAF50) : Colors.white.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      filterOptions[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white.withAlpha(179),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTracksList() {
    return Container(
      color: Colors.black,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: filteredTracks.length,
        itemBuilder: (context, index) {
          final track = filteredTracks[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: (track["isPlaying"] as bool) ? Colors.white.withAlpha(26) : Colors.transparent,
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${track["artwork"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${track["title"]}",
                              style: TextStyle(
                                color: (track["isPlaying"] as bool) ? Color(0xFF4CAF50) : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (track["isDownloaded"] as bool)
                            Icon(
                              Icons.download_done,
                              color: Color(0xFF4CAF50),
                              size: 16,
                            ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          if (track["isPlaying"] as bool)
                            Container(
                              margin: EdgeInsets.only(right: spXs),
                              child: Icon(
                                Icons.graphic_eq,
                                color: Color(0xFF4CAF50),
                                size: 14,
                              ),
                            ),
                          Expanded(
                            child: Text(
                              "${track["artist"]}",
                              style: TextStyle(
                                color: Colors.white.withAlpha(179),
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${((track["plays"] as int) / 1000000).toStringAsFixed(1)}M plays",
                        style: TextStyle(
                          color: Colors.white.withAlpha(128),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        track["isLiked"] = !(track["isLiked"] as bool);
                        setState(() {});
                      },
                      child: Icon(
                        (track["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                        color: (track["isLiked"] as bool) ? Color(0xFF4CAF50) : Colors.white.withAlpha(179),
                        size: 20,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${track["duration"]}",
                      style: TextStyle(
                        color: Colors.white.withAlpha(128),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white.withAlpha(179),
                    size: 20,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
