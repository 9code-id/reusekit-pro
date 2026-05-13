import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVideo10View extends StatefulWidget {
  @override
  State<GrlVideo10View> createState() => _GrlVideo10ViewState();
}

class _GrlVideo10ViewState extends State<GrlVideo10View> {
  bool isRecording = false;
  String selectedFilter = "None";
  double recordingProgress = 0.0;
  int recordingDuration = 0;
  String selectedMusic = "None";

  List<Map<String, dynamic>> filters = [
    {"name": "None", "preview": Colors.transparent},
    {"name": "Vintage", "preview": Colors.orange.withAlpha(128)},
    {"name": "B&W", "preview": Colors.grey.withAlpha(128)},
    {"name": "Warm", "preview": Colors.yellow.withAlpha(128)},
    {"name": "Cool", "preview": Colors.blue.withAlpha(128)},
    {"name": "Dramatic", "preview": Colors.purple.withAlpha(128)},
  ];

  List<Map<String, dynamic>> musicTracks = [
    {
      "id": "1",
      "title": "Upbeat Summer",
      "artist": "Trending Sounds",
      "duration": "0:30",
      "isPopular": true,
    },
    {
      "id": "2",
      "title": "Chill Vibes",
      "artist": "Relax Music",
      "duration": "0:45",
      "isPopular": false,
    },
    {
      "id": "3",
      "title": "Dance Party",
      "artist": "Party Beats",
      "duration": "0:35",
      "isPopular": true,
    },
    {
      "id": "4",
      "title": "Acoustic Guitar",
      "artist": "Indie Folk",
      "duration": "1:00",
      "isPopular": false,
    },
  ];

  List<Map<String, dynamic>> recentVideos = [
    {
      "id": "1",
      "thumbnail": "https://picsum.photos/120/160?random=201&keyword=dance",
      "duration": "0:45",
      "views": 12500,
      "likes": 890,
      "title": "Dance Challenge",
      "createdAt": "2 hours ago",
      "status": "Published",
    },
    {
      "id": "2",
      "thumbnail": "https://picsum.photos/120/160?random=202&keyword=cooking",
      "duration": "1:20",
      "views": 8900,
      "likes": 456,
      "title": "Quick Recipe",
      "createdAt": "1 day ago",
      "status": "Published",
    },
    {
      "id": "3",
      "thumbnail": "https://picsum.photos/120/160?random=203&keyword=workout",
      "duration": "0:30",
      "views": 0,
      "likes": 0,
      "title": "Fitness Routine",
      "createdAt": "Just now",
      "status": "Draft",
    },
  ];

  void _startRecording() {
    if (!isRecording) {
      isRecording = true;
      recordingProgress = 0.0;
      recordingDuration = 0;
      setState(() {});
      
      // Simulate recording progress
      Future.delayed(Duration(milliseconds: 100), _updateProgress);
    } else {
      isRecording = false;
      setState(() {});
    }
  }

  void _updateProgress() {
    if (isRecording && recordingProgress < 1.0) {
      recordingProgress += 0.01;
      recordingDuration++;
      setState(() {});
      Future.delayed(Duration(milliseconds: 100), _updateProgress);
    }
  }

  Widget _buildCameraPreview() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/400/600?random=210&keyword=selfie"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (selectedFilter != "None")
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                color: filters.firstWhere((f) => f["name"] == selectedFilter)["preview"],
              ),
            ),
          if (isRecording)
            Positioned(
              top: spMd,
              left: spMd,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
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
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "REC ${(recordingDuration ~/ 10).toString().padLeft(2, '0')}:${(recordingDuration % 10).toString().padLeft(2, '0')}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            top: spMd,
            right: spMd,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(128),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.flip_camera_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(128),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.flash_on,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(128),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.timer,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isRecording)
            Positioned(
              bottom: spMd,
              left: spMd,
              right: spMd,
              child: LinearProgressIndicator(
                value: recordingProgress,
                backgroundColor: Colors.white.withAlpha(77),
                valueColor: AlwaysStoppedAnimation<Color>(dangerColor),
                minHeight: 4,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecordingControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(26),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.photo_library,
                color: primaryColor,
                size: 24,
              ),
            ),
          ),
          GestureDetector(
            onTap: _startRecording,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isRecording ? dangerColor : primaryColor,
                shape: BoxShape.circle,
                boxShadow: [shadowMd],
              ),
              child: Icon(
                isRecording ? Icons.stop : Icons.videocam,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(26),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.video_library,
                color: primaryColor,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Text(
              "Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(height: spSm),
          QHorizontalScroll(
            children: filters.map((filter) {
              bool isSelected = selectedFilter == filter["name"];
              return GestureDetector(
                onTap: () {
                  selectedFilter = filter["name"];
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(left: spMd),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: filter["preview"],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledColor,
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        child: filter["name"] == "None" ? Icon(
                          Icons.no_photography,
                          color: disabledBoldColor,
                          size: 24,
                        ) : null,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${filter["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMusicSelector() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Music",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Browse All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: disabledColor),
          Column(
            children: musicTracks.take(3).map((track) {
              bool isSelected = selectedMusic == track["title"];
              return GestureDetector(
                onTap: () {
                  selectedMusic = isSelected ? "None" : track["title"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(26) : Colors.transparent,
                    border: Border(
                      bottom: BorderSide(color: disabledColor, width: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${track["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (track["isPopular"] as bool) ...[
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "HOT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              "${track["artist"]} • ${track["duration"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: primaryColor,
                          size: 20,
                        )
                      else
                        Icon(
                          Icons.play_arrow,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentVideos() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Recent Videos",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Divider(height: 1, color: disabledColor),
          QHorizontalScroll(
            children: recentVideos.map((video) {
              return Container(
                width: 120,
                margin: EdgeInsets.only(left: spMd, top: spMd, bottom: spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${video["thumbnail"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(179),
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
                          if (video["status"] == "Draft")
                            Positioned(
                              top: spXs,
                              left: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "DRAFT",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          Center(
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(230),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: primaryColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${video["title"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    if (video["status"] == "Published")
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            color: disabledBoldColor,
                            size: 12,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${((video["views"] as int) / 1000).toInt()}K",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Icon(
                            Icons.favorite,
                            color: dangerColor,
                            size: 12,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${video["likes"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        "${video["createdAt"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          "Create Video",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          if (selectedMusic != "None")
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(right: spMd),
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      selectedMusic,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              child: _buildCameraPreview(),
            ),
            _buildRecordingControls(),
            _buildFilters(),
            _buildMusicSelector(),
            _buildRecentVideos(),
            SizedBox(height: 100), // Space for floating button
          ],
        ),
      ),
      floatingActionButton: !isRecording ? GestureDetector(
        onTap: () {},
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [shadowMd],
          ),
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 30,
          ),
        ),
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
