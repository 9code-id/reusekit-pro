import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLive6View extends StatefulWidget {
  @override
  State<GrlLive6View> createState() => _GrlLive6ViewState();
}

class _GrlLive6ViewState extends State<GrlLive6View> {
  bool isRecording = false;
  bool isFilterEnabled = false;
  int selectedFilter = 0;
  String selectedMusic = "";
  double volume = 0.7;
  int timerSeconds = 0;
  String description = "";
  
  List<Map<String, dynamic>> filters = [
    {"name": "None", "color": Colors.transparent},
    {"name": "Warm", "color": Colors.orange.withAlpha(60)},
    {"name": "Cool", "color": Colors.blue.withAlpha(60)},
    {"name": "Vintage", "color": Colors.brown.withAlpha(60)},
    {"name": "Bright", "color": Colors.yellow.withAlpha(40)},
  ];

  List<Map<String, dynamic>> musicTracks = [
    {
      "title": "Upbeat Summer",
      "artist": "Studio Audio",
      "duration": "0:30",
      "category": "Popular",
    },
    {
      "title": "Chill Vibes",
      "artist": "Background Music",
      "duration": "0:45",
      "category": "Trending",
    },
    {
      "title": "Dance Party",
      "artist": "DJ Mix",
      "duration": "0:30",
      "category": "Dance",
    },
    {
      "title": "Peaceful Moment",
      "artist": "Ambient",
      "duration": "1:00",
      "category": "Calm",
    },
  ];

  void _startRecording() {
    setState(() {
      isRecording = true;
      timerSeconds = 0;
    });
    
    // Start timer
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (isRecording) {
        setState(() {
          timerSeconds++;
        });
        return true;
      }
      return false;
    });
  }

  void _stopRecording() {
    setState(() {
      isRecording = false;
    });
    
    // Show post options
    _showPostOptions();
  }

  void _showPostOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                  Spacer(),
                  Text(
                    "Post Video",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "Post",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Video posted successfully!");
                      back();
                    },
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video preview
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusMd),
                            child: Image.network(
                              "https://picsum.photos/400/300?random=20&keyword=video",
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(120),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Description input
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Write a caption...",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          description = value;
                          setState(() {});
                        },
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Privacy settings
                    Text(
                      "Privacy",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(40),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: primaryColor),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.public, color: primaryColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Public",
                                  style: TextStyle(
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
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.lock, color: disabledBoldColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Private",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Tags
                    Text(
                      "Tags",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: [
                        "#dance", "#music", "#fun", "#trending", "#viral"
                      ].map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimer(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview background
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Image.network(
                  "https://picsum.photos/400/800?random=30&keyword=selfie",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Filter overlay
                if (selectedFilter > 0)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: filters[selectedFilter]["color"] as Color,
                  ),
              ],
            ),
          ),

          // Top controls
          Positioned(
            top: 40,
            left: spMd,
            right: spMd,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => back(),
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                Spacer(),
                // Timer (when recording)
                if (isRecording)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          _formatTimer(timerSeconds),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.flip_camera_ios,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right side controls
          Positioned(
            right: spMd,
            top: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                // Flash
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.flash_off,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),

                SizedBox(height: spMd),

                // Filters
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(200),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spMd),
                              child: Text(
                                "Filters",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: spMd),
                                itemCount: filters.length,
                                itemBuilder: (context, index) {
                                  final filter = filters[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedFilter = index;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 60,
                                      margin: EdgeInsets.only(right: spSm),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(radiusSm),
                                        border: Border.all(
                                          color: selectedFilter == index 
                                              ? primaryColor 
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(radiusSm),
                                            child: Image.network(
                                              "https://picsum.photos/60/80?random=${index + 40}",
                                              width: 60,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            width: 60,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color: filter["color"] as Color,
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: spXs,
                                            left: 0,
                                            right: 0,
                                            child: Text(
                                              "${filter["name"]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.filter_vintage,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),

                SizedBox(height: spMd),

                // Music
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spMd),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Icon(Icons.close),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Add Music",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.search),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: spMd),
                                itemCount: musicTracks.length,
                                itemBuilder: (context, index) {
                                  final track = musicTracks[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedMusic = "${track["title"]}";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(spSm),
                                      margin: EdgeInsets.only(bottom: spSm),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: disabledOutlineBorderColor),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: primaryColor.withAlpha(40),
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Icon(
                                              Icons.music_note,
                                              color: primaryColor,
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "${track["artist"]} • ${track["duration"]}",
                                                  style: TextStyle(
                                                    color: disabledBoldColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: spXs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: primaryColor.withAlpha(40),
                                              borderRadius: BorderRadius.circular(radiusLg),
                                            ),
                                            child: Text(
                                              "${track["category"]}",
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: 40,
            left: spMd,
            right: spMd,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gallery
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "https://picsum.photos/50/50?random=50",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Spacer(),

                // Record button
                GestureDetector(
                  onTap: isRecording ? _stopRecording : _startRecording,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isRecording ? dangerColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                    child: isRecording
                        ? Icon(
                            Icons.stop,
                            color: Colors.white,
                            size: 32,
                          )
                        : Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                  ),
                ),

                Spacer(),

                // Template/Effects
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Selected music indicator
          if (selectedMusic.isNotEmpty)
            Positioned(
              bottom: 140,
              left: spMd,
              right: spMd,
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(120),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      selectedMusic,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMusic = "";
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
