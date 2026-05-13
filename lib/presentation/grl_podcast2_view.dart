import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPodcast2View extends StatefulWidget {
  @override
  State<GrlPodcast2View> createState() => _GrlPodcast2ViewState();
}

class _GrlPodcast2ViewState extends State<GrlPodcast2View> {
  bool isPlaying = false;
  bool isShuffled = false;
  bool isRepeating = false;
  double currentPosition = 0.35; // 35% of the track
  double playbackSpeed = 1.0;
  
  Map<String, dynamic> currentEpisode = {
    "title": "The Future of Artificial Intelligence in Healthcare",
    "podcast": "Tech Insights Weekly",
    "host": "Dr. Sarah Chen",
    "duration": "48:32",
    "currentTime": "17:04",
    "description": "In this episode, we dive deep into how AI is revolutionizing healthcare, from diagnostic imaging to personalized treatment plans. We'll explore the latest breakthroughs and discuss what the future holds for AI-powered medicine.",
    "cover": "https://picsum.photos/300/300?random=1&keyword=healthcare",
    "publishDate": "March 15, 2024",
    "category": "Technology",
    "rating": 4.8,
    "plays": 25600
  };

  List<Map<String, dynamic>> playlist = [
    {
      "title": "The Future of Artificial Intelligence in Healthcare",
      "podcast": "Tech Insights Weekly",
      "duration": "48:32",
      "isCurrentlyPlaying": true,
      "thumbnail": "https://picsum.photos/60/60?random=1&keyword=healthcare"
    },
    {
      "title": "Blockchain Revolution in Finance",
      "podcast": "Future Tech",
      "duration": "42:15",
      "isCurrentlyPlaying": false,
      "thumbnail": "https://picsum.photos/60/60?random=2&keyword=blockchain"
    },
    {
      "title": "Sustainable Energy Solutions",
      "podcast": "Green World",
      "duration": "35:48",
      "isCurrentlyPlaying": false,
      "thumbnail": "https://picsum.photos/60/60?random=3&keyword=energy"
    },
    {
      "title": "Space Exploration Updates",
      "podcast": "Cosmic Journey",
      "duration": "52:20",
      "isCurrentlyPlaying": false,
      "thumbnail": "https://picsum.photos/60/60?random=4&keyword=space"
    }
  ];

  List<Map<String, dynamic>> relatedEpisodes = [
    {
      "title": "Machine Learning in Medical Diagnosis",
      "podcast": "AI & Health",
      "host": "Dr. Mike Johnson",
      "duration": "35:22",
      "thumbnail": "https://picsum.photos/80/80?random=5&keyword=medical",
      "rating": 4.6,
      "plays": 18400
    },
    {
      "title": "Digital Health Transformation",
      "podcast": "HealthTech Today",
      "host": "Lisa Anderson",
      "duration": "41:55",
      "thumbnail": "https://picsum.photos/80/80?random=6&keyword=digital",
      "rating": 4.7,
      "plays": 22100
    },
    {
      "title": "Ethics in AI Healthcare",
      "podcast": "Medical Ethics",
      "host": "Prof. David Wilson",
      "duration": "39:18",
      "thumbnail": "https://picsum.photos/80/80?random=7&keyword=ethics",
      "rating": 4.5,
      "plays": 15800
    }
  ];

  List<double> speedOptions = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: spLg),
                  _buildEpisodeInfo(),
                  SizedBox(height: spLg),
                  _buildProgressSection(),
                  SizedBox(height: spLg),
                  _buildPlaybackControls(),
                  SizedBox(height: spLg),
                  _buildAdditionalControls(),
                  SizedBox(height: spLg),
                  _buildEpisodeDescription(),
                  SizedBox(height: spLg),
                  _buildPlaylistSection(),
                  SizedBox(height: spLg),
                  _buildRelatedEpisodes(),
                ],
              ),
            ),
          ),
          _buildMiniPlayer(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            back();
          },
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Icon(Icons.arrow_back, color: primaryColor),
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Now Playing",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${currentEpisode["podcast"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        QButton(
          icon: Icons.share,
          size: bs.sm,
          onPressed: () {
            ss("Episode shared");
          },
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.more_vert,
          size: bs.sm,
          onPressed: () {
            si("More options");
          },
        ),
      ],
    );
  }

  Widget _buildEpisodeInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusLg),
            child: Image.network(
              "${currentEpisode["cover"]}",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "${currentEpisode["title"]}",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          Text(
            "By ${currentEpisode["host"]}",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEpisodeStat(Icons.schedule, "${currentEpisode["duration"]}"),
              SizedBox(width: spLg),
              _buildEpisodeStat(Icons.calendar_today, "${currentEpisode["publishDate"]}"),
              SizedBox(width: spLg),
              _buildEpisodeStat(Icons.play_circle_filled, "${(currentEpisode["plays"] as int) > 1000 ? '${((currentEpisode["plays"] as int) / 1000).toStringAsFixed(1)}K' : currentEpisode["plays"]} plays"),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${currentEpisode["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${currentEpisode["category"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEpisodeStat(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: disabledBoldColor),
        SizedBox(width: spXs),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${currentEpisode["currentTime"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "${currentEpisode["duration"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
              activeTrackColor: primaryColor,
              inactiveTrackColor: disabledColor,
              thumbColor: primaryColor,
              overlayColor: primaryColor.withAlpha(50),
            ),
            child: Slider(
              value: currentPosition,
              onChanged: (value) {
                currentPosition = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaybackControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(
            icon: isShuffled ? Icons.shuffle : Icons.shuffle,
            color: isShuffled ? primaryColor : disabledBoldColor,
            onTap: () {
              isShuffled = !isShuffled;
              setState(() {});
              si(isShuffled ? "Shuffle enabled" : "Shuffle disabled");
            },
          ),
          _buildControlButton(
            icon: Icons.skip_previous,
            color: primaryColor,
            onTap: () {
              si("Previous episode");
            },
          ),
          _buildControlButton(
            icon: Icons.replay,
            color: primaryColor,
            onTap: () {
              si("Rewinded 15 seconds");
            },
          ),
          GestureDetector(
            onTap: () {
              isPlaying = !isPlaying;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                boxShadow: [shadowMd],
              ),
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          _buildControlButton(
            icon: Icons.forward_30,
            color: primaryColor,
            onTap: () {
              si("Fast forwarded 30 seconds");
            },
          ),
          _buildControlButton(
            icon: Icons.skip_next,
            color: primaryColor,
            onTap: () {
              si("Next episode");
            },
          ),
          _buildControlButton(
            icon: isRepeating ? Icons.repeat_one : Icons.repeat,
            color: isRepeating ? primaryColor : disabledBoldColor,
            onTap: () {
              isRepeating = !isRepeating;
              setState(() {});
              si(isRepeating ? "Repeat enabled" : "Repeat disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildAdditionalControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(Icons.speed, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Text(
                  "Speed:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QHorizontalScroll(
                    children: speedOptions.map((speed) {
                      bool isSelected = speed == playbackSpeed;
                      return GestureDetector(
                        onTap: () {
                          playbackSpeed = speed;
                          setState(() {});
                          si("Playback speed set to ${speed}x");
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spXs),
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Text(
                            "${speed}x",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spMd),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              ss("Episode downloaded");
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.bookmark_border,
            size: bs.sm,
            onPressed: () {
              ss("Episode bookmarked");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEpisodeDescription() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Episode Description",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "${currentEpisode["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.playlist_play,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              "Up Next",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "View All",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: spMd),
        Column(
          children: playlist.map((episode) {
            bool isCurrent = episode["isCurrentlyPlaying"] as bool;
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isCurrent ? primaryColor.withAlpha(10) : Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isCurrent ? primaryColor : disabledOutlineBorderColor,
                ),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${episode["thumbnail"]}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (isCurrent)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 20,
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
                          "${episode["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isCurrent ? primaryColor : disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${episode["podcast"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
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
                  if (!isCurrent)
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
    );
  }

  Widget _buildRelatedEpisodes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.recommend,
              color: warningColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              "Related Episodes",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        Column(
          children: relatedEpisodes.map((episode) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusXs),
                    child: Image.network(
                      "${episode["thumbnail"]}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${episode["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${episode["podcast"]} • ${episode["host"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${episode["duration"]}",
                              style: TextStyle(fontSize: 10, color: disabledBoldColor),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.star, size: 12, color: warningColor),
                            SizedBox(width: spXs),
                            Text(
                              "${episode["rating"]}",
                              style: TextStyle(fontSize: 10, color: warningColor),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.play_circle_filled, size: 12, color: successColor),
                            SizedBox(width: spXs),
                            Text(
                              "${(episode["plays"] as int) > 1000 ? '${((episode["plays"] as int) / 1000).toStringAsFixed(1)}K' : episode["plays"]}",
                              style: TextStyle(fontSize: 10, color: successColor),
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
    );
  }

  Widget _buildMiniPlayer() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: [shadowLg],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusXs),
            child: Image.network(
              "${currentEpisode["cover"]}",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${currentEpisode["podcast"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withAlpha(200),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${currentEpisode["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              isPlaying = !isPlaying;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {
              si("Next episode");
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                Icons.skip_next,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
