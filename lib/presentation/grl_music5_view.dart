import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMusic5View extends StatefulWidget {
  @override
  State<GrlMusic5View> createState() => _GrlMusic5ViewState();
}

class _GrlMusic5ViewState extends State<GrlMusic5View> {
  bool isPlaying = false;
  bool isRepeat = false;
  bool isShuffle = false;
  bool isLiked = true;
  double currentTime = 125.0;
  double totalTime = 243.0;

  Map<String, dynamic> currentSong = {
    "title": "Watermelon Sugar",
    "artist": "Harry Styles",
    "album": "Fine Line",
    "image": "https://picsum.photos/300/300?random=1&keyword=music",
    "year": "2020",
    "genre": "Pop",
  };

  List<Map<String, dynamic>> queue = [
    {
      "title": "Adore You",
      "artist": "Harry Styles",
      "duration": "3:27",
      "image": "https://picsum.photos/60/60?random=2&keyword=pop",
    },
    {
      "title": "Golden",
      "artist": "Harry Styles",
      "duration": "3:28",
      "image": "https://picsum.photos/60/60?random=3&keyword=indie",
    },
    {
      "title": "Falling",
      "artist": "Harry Styles",
      "duration": "4:00",
      "image": "https://picsum.photos/60/60?random=4&keyword=ballad",
    },
    {
      "title": "Cherry",
      "artist": "Harry Styles",
      "duration": "4:11",
      "image": "https://picsum.photos/60/60?random=5&keyword=love",
    },
  ];

  String _formatTime(double seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = (seconds % 60).floor();
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(30),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: [
                      _buildAlbumArt(),
                      SizedBox(height: spLg),
                      _buildSongInfo(),
                      SizedBox(height: spLg),
                      _buildProgressBar(),
                      SizedBox(height: spLg),
                      _buildControls(),
                      SizedBox(height: spLg),
                      _buildQueue(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(spMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(200),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "Now Playing",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(200),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.more_vert,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumArt() {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowLg],
        image: DecorationImage(
          image: NetworkImage("${currentSong["image"]}"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusLg),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withAlpha(50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSongInfo() {
    return Column(
      children: [
        Text(
          "${currentSong["title"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "${currentSong["artist"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fsH6,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${currentSong["album"]} • ${currentSong["year"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: primaryColor,
            inactiveTrackColor: disabledColor,
            thumbColor: primaryColor,
            overlayColor: primaryColor.withAlpha(50),
            trackHeight: 4,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: currentTime,
            min: 0,
            max: totalTime,
            onChanged: (value) {
              currentTime = value;
              setState(() {});
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spMd),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatTime(currentTime),
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                _formatTime(totalTime),
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            isShuffle = !isShuffle;
            setState(() {});
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isShuffle ? primaryColor.withAlpha(30) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shuffle,
              color: isShuffle ? primaryColor : disabledBoldColor,
              size: 24,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [shadowSm],
            ),
            child: Icon(
              Icons.skip_previous,
              color: primaryColor,
              size: 30,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            isPlaying = !isPlaying;
            setState(() {});
          },
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
              boxShadow: [shadowMd],
            ),
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [shadowSm],
            ),
            child: Icon(
              Icons.skip_next,
              color: primaryColor,
              size: 30,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            isRepeat = !isRepeat;
            setState(() {});
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isRepeat ? primaryColor.withAlpha(30) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.repeat,
              color: isRepeat ? primaryColor : disabledBoldColor,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQueue() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      isLiked = !isLiked;
                      setState(() {});
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_outline,
                      color: isLiked ? dangerColor : disabledBoldColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.share,
                      color: disabledBoldColor,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...queue.map((song) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      image: DecorationImage(
                        image: NetworkImage("${song["image"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${song["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${song["artist"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${song["duration"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
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
            );
          }).toList(),
        ],
      ),
    );
  }
}
