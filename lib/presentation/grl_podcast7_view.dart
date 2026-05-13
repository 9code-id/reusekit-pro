import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPodcast7View extends StatefulWidget {
  @override
  State<GrlPodcast7View> createState() => _GrlPodcast7ViewState();
}

class _GrlPodcast7ViewState extends State<GrlPodcast7View> {
  String currentEpisode = "The Future of AI in Healthcare";
  String currentPodcast = "Tech Healthcare Weekly";
  double currentProgress = 0.65;
  String currentTime = "18:42";
  String totalTime = "28:45";
  bool isPlaying = true;
  double playbackSpeed = 1.0;
  bool isLiked = false;

  List<Map<String, dynamic>> upNext = [
    {
      "title": "Machine Learning Breakthroughs",
      "podcast": "Tech Healthcare Weekly",
      "duration": "32:15",
      "image": "https://picsum.photos/200/200?random=1&keyword=medical",
    },
    {
      "title": "Digital Health Trends 2024",
      "podcast": "Health Innovation",
      "duration": "25:30",
      "image": "https://picsum.photos/200/200?random=2&keyword=health",
    },
    {
      "title": "Telemedicine Revolution",
      "podcast": "Digital Care",
      "duration": "38:20",
      "image": "https://picsum.photos/200/200?random=3&keyword=telemedicine",
    }
  ];

  List<double> speedOptions = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Now Playing"),
        actions: [
          IconButton(
            icon: Icon(Icons.cast),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Album Art
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/400/400?random=1&keyword=podcast"),
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
                      Text(
                        currentEpisode,
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        currentPodcast,
                        style: TextStyle(
                          fontSize: fsH6,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: spLg),

            // Progress Bar
            Column(
              children: [
                LinearProgressIndicator(
                  value: currentProgress,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  minHeight: 6,
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
                  icon: Icons.replay_10,
                  size: bs.md,
                  onPressed: () {},
                ),
                QButton(
                  icon: Icons.skip_previous,
                  size: bs.md,
                  onPressed: () {},
                ),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [shadowMd],
                  ),
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
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
                  icon: Icons.forward_30,
                  size: bs.md,
                  onPressed: () {},
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Secondary Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    QButton(
                      icon: Icons.speed,
                      size: bs.sm,
                      onPressed: () {
                        _showSpeedDialog();
                      },
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${playbackSpeed}x",
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
                      icon: Icons.bedtime,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Timer",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Up Next Section
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
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        icon: Icons.shuffle,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    children: upNext.map((episode) {
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
                                  image: NetworkImage("${episode["image"]}"),
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
                                    "${episode["title"]}",
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
                                        "${episode["podcast"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: secondaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${episode["duration"]}",
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

            SizedBox(height: spLg),

            // Episode Description
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
                  Text(
                    "Episode Description",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "In this episode, we explore the cutting-edge applications of artificial intelligence in healthcare. From diagnostic tools to personalized treatment plans, AI is revolutionizing how we approach medical care. Join us as we discuss the latest breakthroughs, challenges, and future possibilities in this rapidly evolving field.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSpeedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Playback Speed"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: speedOptions.map((speed) {
              return RadioListTile<double>(
                title: Text("${speed}x"),
                value: speed,
                groupValue: playbackSpeed,
                onChanged: (double? value) {
                  if (value != null) {
                    playbackSpeed = value;
                    setState(() {});
                    Navigator.of(context).pop();
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
