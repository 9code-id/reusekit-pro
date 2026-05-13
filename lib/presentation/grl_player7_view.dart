import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlayer7View extends StatefulWidget {
  @override
  State<GrlPlayer7View> createState() => _GrlPlayer7ViewState();
}

class _GrlPlayer7ViewState extends State<GrlPlayer7View> {
  bool isPlaying = true;
  bool isShuffled = false;
  bool isRepeated = false;
  bool isLiked = true;
  double currentPosition = 0.4;
  int selectedTab = 0;
  
  Map<String, dynamic> currentTrack = {
    "title": "Golden Hour",
    "artist": "Sunset Collective",
    "album": "Summer Memories",
    "duration": "4:25",
    "currentTime": "1:46",
    "artwork": "https://picsum.photos/400/400?random=30&keyword=sunset",
    "year": "2024",
    "genre": "Indie Pop",
    "plays": 2847329,
    "likes": 98432,
  };

  List<Map<String, dynamic>> lyrics = [
    {"time": "0:00", "text": "Walking through the golden fields", "isActive": false},
    {"time": "0:15", "text": "Summer breeze beneath my feet", "isActive": false},
    {"time": "0:30", "text": "Colors dancing in the light", "isActive": false},
    {"time": "0:45", "text": "Everything feels so right", "isActive": false},
    {"time": "1:00", "text": "Golden hour, shine on me", "isActive": true},
    {"time": "1:15", "text": "Take me where I want to be", "isActive": false},
    {"time": "1:30", "text": "In this moment, I am free", "isActive": false},
    {"time": "1:45", "text": "Golden hour, eternally", "isActive": false},
  ];

  List<Map<String, dynamic>> comments = [
    {
      "user": "MusicLover92",
      "avatar": "https://picsum.photos/40/40?random=31&keyword=avatar",
      "comment": "This song gives me life! Perfect for summer drives 🌅",
      "time": "2 hours ago",
      "likes": 24,
    },
    {
      "user": "VibeMaster",
      "avatar": "https://picsum.photos/40/40?random=32&keyword=avatar",
      "comment": "The production quality is incredible. Can't stop listening!",
      "time": "5 hours ago",
      "likes": 18,
    },
    {
      "user": "SunsetFan",
      "avatar": "https://picsum.photos/40/40?random=33&keyword=avatar",
      "comment": "Been waiting for this drop. Worth every second 🔥",
      "time": "1 day ago",
      "likes": 31,
    },
  ];

  List<Map<String, dynamic>> relatedTracks = [
    {
      "title": "Midnight Sun",
      "artist": "Sunset Collective",
      "duration": "3:52",
      "artwork": "https://picsum.photos/60/60?random=34&keyword=midnight",
      "plays": 1247892,
    },
    {
      "title": "Ocean Dreams",
      "artist": "Sunset Collective", 
      "duration": "4:18",
      "artwork": "https://picsum.photos/60/60?random=35&keyword=ocean",
      "plays": 892341,
    },
    {
      "title": "City Lights",
      "artist": "Urban Vibes",
      "duration": "3:44",
      "artwork": "https://picsum.photos/60/60?random=36&keyword=city",
      "plays": 1523671,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF8A65),
              Color(0xFFFF7043),
              Color(0xFFFF5722),
              Color(0xFFBF360C),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXl)),
                ),
                child: Column(
                  children: [
                    _buildPlayerSection(),
                    _buildTabSection(),
                    Expanded(child: _buildTabContent()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(spMd, MediaQuery.of(context).padding.top + spSm, spMd, spLg),
      child: Column(
        children: [
          Row(
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
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Now Playing",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(77),
                  blurRadius: 25,
                  offset: Offset(0, 15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Image.network(
                "${currentTrack["artwork"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${currentTrack["title"]}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${currentTrack["artist"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  isLiked = !isLiked;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isLiked ? Colors.red.withAlpha(26) : disabledColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : disabledBoldColor,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Text(
                "${((currentTrack["plays"] as int) / 1000000).toStringAsFixed(1)}M plays",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
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
                "${((currentTrack["likes"] as int) / 1000).toStringAsFixed(1)}K likes",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 6,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 6,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
                activeTrackColor: Color(0xFFFF5722),
                inactiveTrackColor: disabledColor,
                thumbColor: Color(0xFFFF5722),
                overlayColor: Color(0xFFFF5722).withAlpha(51),
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
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${currentTrack["duration"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  isShuffled = !isShuffled;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isShuffled ? Color(0xFFFF5722).withAlpha(26) : disabledColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.shuffle,
                    color: isShuffled ? Color(0xFFFF5722) : disabledBoldColor,
                    size: 20,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.skip_previous,
                  color: Colors.black,
                  size: 32,
                ),
              ),
              GestureDetector(
                onTap: () {
                  isPlaying = !isPlaying;
                  setState(() {});
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF5722),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFF5722).withAlpha(77),
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
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.skip_next,
                  color: Colors.black,
                  size: 32,
                ),
              ),
              GestureDetector(
                onTap: () {
                  isRepeated = !isRepeated;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isRepeated ? Color(0xFFFF5722).withAlpha(26) : disabledColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.repeat,
                    color: isRepeated ? Color(0xFFFF5722) : disabledBoldColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Row(
        children: [
          _buildTabButton("Lyrics", 0),
          _buildTabButton("Comments", 1),
          _buildTabButton("Related", 2),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Color(0xFFFF5722) : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Color(0xFFFF5722) : disabledBoldColor,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildLyricsTab();
      case 1:
        return _buildCommentsTab();
      case 2:
        return _buildRelatedTab();
      default:
        return _buildLyricsTab();
    }
  }

  Widget _buildLyricsTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: ListView.builder(
        itemCount: lyrics.length,
        itemBuilder: (context, index) {
          final lyric = lyrics[index];
          bool isActive = lyric["isActive"] as bool;
          return Container(
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  child: Text(
                    "${lyric["time"]}",
                    style: TextStyle(
                      color: isActive ? Color(0xFFFF5722) : disabledBoldColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${lyric["text"]}",
                    style: TextStyle(
                      color: isActive ? Colors.black : disabledBoldColor,
                      fontSize: isActive ? 16 : 14,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCommentsTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: disabledColor,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          margin: EdgeInsets.all(spMd),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Add a comment...",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ),
              Icon(
                Icons.send,
                color: disabledBoldColor,
                size: 20,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("${comment["avatar"]}"),
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
                              Text(
                                "${comment["user"]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${comment["time"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${comment["comment"]}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      color: disabledBoldColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${comment["likes"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spMd),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Reply",
                                  style: TextStyle(
                                    color: Color(0xFFFF5722),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedTab() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: relatedTracks.length,
      itemBuilder: (context, index) {
        final track = relatedTracks[index];
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: disabledColor,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
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
                    Text(
                      "${((track["plays"] as int) / 1000000).toStringAsFixed(1)}M plays • ${track["duration"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Color(0xFFFF5722),
                    borderRadius: BorderRadius.circular(radiusLg),
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
        );
      },
    );
  }
}
