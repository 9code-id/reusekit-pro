import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaStoriesView extends StatefulWidget {
  const SmaStoriesView({super.key});

  @override
  State<SmaStoriesView> createState() => _SmaStoriesViewState();
}

class _SmaStoriesViewState extends State<SmaStoriesView> {
  String currentStoryType = "camera";
  String storyText = "";
  String selectedMusic = "";
  List<String> selectedImages = [];
  
  List<Map<String, dynamic>> storyOptions = [
    {"label": "Camera", "value": "camera", "icon": Icons.camera_alt},
    {"label": "Text", "value": "text", "icon": Icons.text_fields},
    {"label": "Music", "value": "music", "icon": Icons.music_note},
    {"label": "Boomerang", "value": "boomerang", "icon": Icons.loop},
  ];
  
  List<Map<String, dynamic>> musicTracks = [
    {
      "title": "Summer Vibes",
      "artist": "Chill Beats",
      "duration": "2:30",
      "cover": "https://picsum.photos/60/60?random=1&keyword=music",
    },
    {
      "title": "Motivation",
      "artist": "Upbeat Sounds",
      "duration": "3:15",
      "cover": "https://picsum.photos/60/60?random=2&keyword=music",
    },
    {
      "title": "Peaceful Mind",
      "artist": "Ambient Music",
      "duration": "4:00",
      "cover": "https://picsum.photos/60/60?random=3&keyword=music",
    },
    {
      "title": "Energy Boost",
      "artist": "Electronic Mix",
      "duration": "2:45",
      "cover": "https://picsum.photos/60/60?random=4&keyword=music",
    },
  ];
  
  List<Map<String, dynamic>> recentStories = [
    {
      "id": "1",
      "author": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      },
      "timestamp": "2 hours ago",
      "type": "photo",
      "content": "https://picsum.photos/300/500?random=1&keyword=story",
      "views": 45,
      "isViewed": false,
    },
    {
      "id": "2",
      "author": {
        "name": "Mike Chen",
        "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      },
      "timestamp": "4 hours ago",
      "type": "text",
      "content": "Living my best life! 🌟",
      "backgroundColor": "#FF6B6B",
      "views": 28,
      "isViewed": true,
    },
    {
      "id": "3",
      "author": {
        "name": "Emily Rodriguez",
        "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      },
      "timestamp": "6 hours ago",
      "type": "photo",
      "content": "https://picsum.photos/300/500?random=2&keyword=food",
      "views": 67,
      "isViewed": false,
    },
    {
      "id": "4",
      "author": {
        "name": "David Thompson",
        "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
      },
      "timestamp": "8 hours ago",
      "type": "video",
      "content": "https://picsum.photos/300/500?random=3&keyword=workout",
      "views": 89,
      "isViewed": true,
    },
  ];
  
  List<Color> textBackgrounds = [
    Color(0xFF6C5CE7),
    Color(0xFFFF6B6B),
    Color(0xFF4ECDC4),
    Color(0xFFFFE66D),
    Color(0xFFA8E6CF),
    Color(0xFFFF8B94),
    Color(0xFF74B9FF),
    Color(0xFFFD79A8),
  ];
  
  Color selectedBackground = Color(0xFF6C5CE7);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("Stories"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStoryOptions(),
          Expanded(
            child: _buildStoryCreation(),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }
  
  Widget _buildStoryOptions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: storyOptions.map((option) {
          final isSelected = currentStoryType == option["value"];
          return GestureDetector(
            onTap: () {
              currentStoryType = option["value"];
              setState(() {});
            },
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey.shade800,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    option["icon"] as IconData,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${option["label"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildStoryCreation() {
    switch (currentStoryType) {
      case "camera":
        return _buildCameraStory();
      case "text":
        return _buildTextStory();
      case "music":
        return _buildMusicStory();
      case "boomerang":
        return _buildBoomerangStory();
      default:
        return _buildCameraStory();
    }
  }
  
  Widget _buildCameraStory() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                color: Colors.grey.shade800,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 80,
                      color: Colors.white,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Camera Preview",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: spMd),
                      child: QButton(
                        label: "Take Photo",
                        onPressed: () {
                          ss("Photo captured!");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildRecentStories(),
        ],
      ),
    );
  }
  
  Widget _buildTextStory() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: selectedBackground,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: TextField(
                        onChanged: (value) {
                          storyText = value;
                          setState(() {});
                        },
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Type your story...",
                          hintStyle: TextStyle(
                            color: Colors.white.withAlpha(150),
                            fontSize: 24,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  _buildColorPalette(),
                ],
              ),
            ),
          ),
          _buildRecentStories(),
        ],
      ),
    );
  }
  
  Widget _buildColorPalette() {
    return Container(
      height: 60,
      child: QHorizontalScroll(
        children: textBackgrounds.map((color) {
          final isSelected = selectedBackground == color;
          return GestureDetector(
            onTap: () {
              selectedBackground = color;
              setState(() {});
            },
            child: Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildMusicStory() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Choose Music",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ...List.generate(musicTracks.length, (index) {
                    final track = musicTracks[index];
                    return _buildMusicTrack(track);
                  }),
                ],
              ),
            ),
          ),
          _buildRecentStories(),
        ],
      ),
    );
  }
  
  Widget _buildMusicTrack(Map<String, dynamic> track) {
    final isSelected = selectedMusic == track["title"];
    
    return GestureDetector(
      onTap: () {
        selectedMusic = track["title"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        margin: EdgeInsets.only(bottom: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(100) : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusSm),
                image: DecorationImage(
                  image: NetworkImage("${track["cover"]}"),
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${track["artist"]} • ${track["duration"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.play_circle,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBoomerangStory() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                color: Colors.grey.shade800,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.loop,
                      size: 80,
                      color: Colors.white,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Boomerang Mode",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Hold to record a looping video",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: spMd),
                      child: QButton(
                        label: "Start Recording",
                        onPressed: () {
                          ss("Boomerang recording started!");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildRecentStories(),
        ],
      ),
    );
  }
  
  Widget _buildRecentStories() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Recent Stories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Container(
            height: 100,
            child: QHorizontalScroll(
              children: List.generate(recentStories.length, (index) {
                final story = recentStories[index];
                return _buildRecentStoryItem(story);
              }),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRecentStoryItem(Map<String, dynamic> story) {
    return Container(
      width: 70,
      margin: EdgeInsets.only(right: spSm),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: story["isViewed"] ? Colors.grey : primaryColor,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: story["type"] == "text"
                  ? Container(
                      color: Color(int.parse(story["backgroundColor"].substring(1), radix: 16) + 0xFF000000),
                      child: Center(
                        child: Text(
                          "${story["content"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  : Image.network(
                      "${story["content"]}",
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${story["author"]["name"]}",
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
      ),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: QButton(
              label: "Save Draft",
              onPressed: () {
                ss("Story saved as draft!");
              },
            ),
          ),
          Expanded(
            child: QButton(
              label: "Share Story",
              onPressed: () {
                ss("Story shared successfully!");
              },
            ),
          ),
        ],
      ),
    );
  }
}
