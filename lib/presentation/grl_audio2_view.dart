import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAudio2View extends StatefulWidget {
  @override
  State<GrlAudio2View> createState() => _GrlAudio2ViewState();
}

class _GrlAudio2ViewState extends State<GrlAudio2View> {
  Map<String, dynamic> currentTrack = {
    "title": "Midnight Jazz Session",
    "artist": "Blue Note Collective",
    "album": "Evening Moods",
    "image": "https://picsum.photos/400/400?random=1&keyword=jazz",
    "duration": "4:35",
    "genre": "Jazz"
  };

  double currentProgress = 0.45;
  String currentTime = "2:05";
  String totalTime = "4:35";
  bool isPlaying = true;
  bool isShuffled = false;
  bool isRepeating = false;
  double volume = 0.7;
  bool isLiked = false;
  double playbackSpeed = 1.0;

  List<Map<String, dynamic>> queue = [
    {
      "title": "Smooth Operator",
      "artist": "Jazz Lounge",
      "image": "https://picsum.photos/200/200?random=2&keyword=smooth",
      "duration": "3:22"
    },
    {
      "title": "Blue Monday",
      "artist": "Chill Vibes",
      "image": "https://picsum.photos/200/200?random=3&keyword=blue",
      "duration": "4:15"
    },
    {
      "title": "Coffee Shop Blues",
      "artist": "Urban Sounds",
      "image": "https://picsum.photos/200/200?random=4&keyword=coffee",
      "duration": "3:45"
    },
    {
      "title": "Rainy Evening",
      "artist": "Ambient Collection",
      "image": "https://picsum.photos/200/200?random=5&keyword=rain",
      "duration": "5:12"
    }
  ];

  List<String> equalizer = ["60Hz", "170Hz", "310Hz", "600Hz", "1kHz", "3kHz", "6kHz", "12kHz", "14kHz", "16kHz"];
  List<double> eqValues = [0.0, 0.2, 0.1, 0.3, 0.4, 0.2, 0.1, 0.0, -0.1, -0.2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor.withAlpha(50),
              Colors.white,
              secondaryColor.withAlpha(30),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        //navigateTo('back')
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 32,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Now Playing",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.more_vert,
                        size: 24,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spLg),

                // Album Art
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusLg),
                    image: DecorationImage(
                      image: NetworkImage("${currentTrack["image"]}"),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [shadowLg],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(100),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(200),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${currentTrack["genre"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: spLg),

                // Track Info
                Column(
                  children: [
                    Text(
                      "${currentTrack["title"]}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${currentTrack["artist"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${currentTrack["album"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                SizedBox(height: spLg),

                // Progress Bar
                Column(
                  children: [
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: LinearProgressIndicator(
                        value: currentProgress,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        minHeight: 8,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentTime,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          totalTime,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: spLg),

                // Main Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    QButton(
                      icon: isShuffled ? Icons.shuffle_on : Icons.shuffle,
                      size: bs.md,
                      onPressed: () {
                        isShuffled = !isShuffled;
                        setState(() {});
                      },
                    ),
                    QButton(
                      icon: Icons.skip_previous,
                      size: bs.md,
                      onPressed: () {},
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [shadowLg],
                      ),
                      child: IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          isPlaying = !isPlaying;
                          setState(() {});
                        },
                      ),
                    ),
                    QButton(
                      icon: Icons.skip_next,
                      size: bs.md,
                      onPressed: () {},
                    ),
                    QButton(
                      icon: isRepeating ? Icons.repeat_on : Icons.repeat,
                      size: bs.md,
                      onPressed: () {
                        isRepeating = !isRepeating;
                        setState(() {});
                      },
                    ),
                  ],
                ),

                SizedBox(height: spLg),

                // Secondary Controls
                Container(
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      // Volume Control
                      Row(
                        children: [
                          Icon(
                            Icons.volume_down,
                            color: disabledBoldColor,
                          ),
                          Expanded(
                            child: Slider(
                              value: volume,
                              onChanged: (value) {
                                volume = value;
                                setState(() {});
                              },
                              activeColor: primaryColor,
                              inactiveColor: disabledColor,
                            ),
                          ),
                          Icon(
                            Icons.volume_up,
                            color: disabledBoldColor,
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              QButton(
                                icon: isLiked ? Icons.favorite : Icons.favorite_border,
                                size: bs.sm,
                                onPressed: () {
                                  isLiked = !isLiked;
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Like",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              QButton(
                                icon: Icons.playlist_add,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Playlist",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              QButton(
                                icon: Icons.download,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Download",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              QButton(
                                icon: Icons.share,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Share",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              QButton(
                                icon: Icons.equalizer,
                                size: bs.sm,
                                onPressed: () {
                                  _showEqualizerDialog();
                                },
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "EQ",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spLg),

                // Up Next Queue
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spLg),
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
                          QButton(
                            icon: Icons.queue_music,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Column(
                        children: queue.take(3).map((track) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${track["image"]}"),
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Text(
                                            "${track["artist"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: secondaryColor,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "${track["duration"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  icon: Icons.play_arrow,
                                  size: bs.sm,
                                  onPressed: () {},
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
            ),
          ),
        ),
      ),
    );
  }

  void _showEqualizerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Equalizer"),
              content: Container(
                width: double.maxFinite,
                height: 300,
                child: Column(
                  children: [
                    Text(
                      "Adjust frequency bands",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: equalizer.asMap().entries.map((entry) {
                          int index = entry.key;
                          String freq = entry.value;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Slider(
                                    value: eqValues[index],
                                    min: -1.0,
                                    max: 1.0,
                                    onChanged: (value) {
                                      setDialogState(() {
                                        eqValues[index] = value;
                                      });
                                    },
                                    activeColor: primaryColor,
                                    inactiveColor: disabledColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                freq,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Reset to default
                    setDialogState(() {
                      eqValues = List.filled(10, 0.0);
                    });
                  },
                  child: Text("Reset"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: Text("Done"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
