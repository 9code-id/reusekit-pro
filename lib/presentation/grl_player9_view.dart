import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlayer9View extends StatefulWidget {
  @override
  State<GrlPlayer9View> createState() => _GrlPlayer9ViewState();
}

class _GrlPlayer9ViewState extends State<GrlPlayer9View> {
  bool isPlaying = false;
  bool isShuffled = true;
  bool isRepeated = false;
  bool isLiked = false;
  double currentPosition = 0.0;
  int selectedPlaylist = 0;
  
  Map<String, dynamic> currentTrack = {
    "title": "Silent Echoes",
    "artist": "Minimalist Sounds",
    "album": "Quiet Moments",
    "duration": "3:12",
    "currentTime": "0:00",
    "artwork": "https://picsum.photos/300/300?random=50&keyword=minimal",
    "year": "2024",
    "genre": "Minimal",
  };

  List<Map<String, dynamic>> recentPlaylists = [
    {
      "name": "Chill Vibes",
      "tracks": 24,
      "artwork": "https://picsum.photos/120/120?random=51&keyword=chill",
      "isActive": true,
    },
    {
      "name": "Study Focus",
      "tracks": 18,
      "artwork": "https://picsum.photos/120/120?random=52&keyword=study",
      "isActive": false,
    },
    {
      "name": "Night Drive",
      "tracks": 32,
      "artwork": "https://picsum.photos/120/120?random=53&keyword=night",
      "isActive": false,
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {"icon": Icons.favorite_border, "label": "Like", "color": Colors.red},
    {"icon": Icons.playlist_add, "label": "Add to Playlist", "color": primaryColor},
    {"icon": Icons.share, "label": "Share", "color": Colors.blue},
    {"icon": Icons.download, "label": "Download", "color": Colors.green},
    {"icon": Icons.info_outline, "label": "Track Info", "color": Colors.orange},
    {"icon": Icons.radio, "label": "Radio", "color": Colors.purple},
  ];

  List<Map<String, dynamic>> recentTracks = [
    {
      "title": "Silent Echoes",
      "artist": "Minimalist Sounds",
      "duration": "3:12",
      "artwork": "https://picsum.photos/60/60?random=50&keyword=minimal",
      "isPlaying": false,
    },
    {
      "title": "Peaceful Morning",
      "artist": "Calm Collective",
      "duration": "4:05",
      "artwork": "https://picsum.photos/60/60?random=54&keyword=morning",
      "isPlaying": false,
    },
    {
      "title": "Gentle Rain",
      "artist": "Nature Sounds",
      "duration": "5:18",
      "artwork": "https://picsum.photos/60/60?random=55&keyword=rain",
      "isPlaying": false,
    },
    {
      "title": "Soft Whispers",
      "artist": "Ambient Dreams",
      "duration": "3:44",
      "artwork": "https://picsum.photos/60/60?random=56&keyword=whisper",
      "isPlaying": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildMiniPlayer(),
            _buildPlaylistSection(),
            _buildQuickActions(),
            _buildRecentTracks(),
            SizedBox(height: spXl),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(spMd, MediaQuery.of(context).padding.top + spSm, spMd, spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => back(),
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Music Player",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
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
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniPlayer() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${currentTrack["artwork"]}"),
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
                      "${currentTrack["title"]}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${currentTrack["artist"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              _buildMiniControlButton(
                icon: Icons.skip_previous,
                onTap: () {},
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () {
                  isPlaying = !isPlaying;
                  setState(() {});
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withAlpha(77),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              _buildMiniControlButton(
                icon: Icons.skip_next,
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 4,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                activeTrackColor: primaryColor,
                inactiveTrackColor: disabledColor,
                thumbColor: primaryColor,
                overlayColor: primaryColor.withAlpha(51),
              ),
              child: Slider(
                value: currentPosition,
                onChanged: (value) {
                  currentPosition = value;
                  setState(() {});
                },
              ),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${currentTrack["currentTime"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
              Text(
                "${currentTrack["duration"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniControlButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: disabledColor,
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Icon(
          icon,
          color: disabledBoldColor,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildPlaylistSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Playlists",
            style: TextStyle(
              color: Colors.black,
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: List.generate(recentPlaylists.length, (index) {
              final playlist = recentPlaylists[index];
              return Container(
                width: 150,
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedPlaylist = index;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: (playlist["isActive"] as bool) ? primaryColor : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${playlist["artwork"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${playlist["name"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${playlist["tracks"]} tracks",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
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

  Widget _buildQuickActions() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              color: Colors.black,
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: quickActions.map((action) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: GestureDetector(
                  onTap: () {
                    if (action["label"] == "Like") {
                      isLiked = !isLiked;
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            isLiked && action["label"] == "Like" ? Icons.favorite : action["icon"] as IconData,
                            color: isLiked && action["label"] == "Like" ? Colors.red : action["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${action["label"]}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTracks() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Recently Played",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "See All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recentTracks.length,
            itemBuilder: (context, index) {
              final track = recentTracks[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
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
                          Text(
                            "${track["title"]}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${track["artist"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(width: spSm),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: disabledBoldColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${track["duration"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              color: primaryColor,
                              size: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
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
            },
          ),
        ],
      ),
    );
  }
}
