import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMeditation9View extends StatefulWidget {
  @override
  State<GrlMeditation9View> createState() => _GrlMeditation9ViewState();
}

class _GrlMeditation9ViewState extends State<GrlMeditation9View> {
  List<Map<String, dynamic>> soundCategories = [
    {
      "title": "Nature",
      "icon": Icons.nature,
      "color": successColor,
      "sounds": [
        {
          "name": "Rain Forest",
          "duration": "60 min",
          "image": "https://picsum.photos/100/100?random=1&keyword=forest",
          "isPlaying": false,
          "isFavorite": true,
        },
        {
          "name": "Ocean Waves",
          "duration": "45 min",
          "image": "https://picsum.photos/100/100?random=2&keyword=ocean",
          "isPlaying": false,
          "isFavorite": false,
        },
        {
          "name": "Thunderstorm",
          "duration": "30 min",
          "image": "https://picsum.photos/100/100?random=3&keyword=storm",
          "isPlaying": true,
          "isFavorite": true,
        },
        {
          "name": "Mountain Wind",
          "duration": "50 min",
          "image": "https://picsum.photos/100/100?random=4&keyword=mountain",
          "isPlaying": false,
          "isFavorite": false,
        },
      ],
    },
    {
      "title": "Ambient",
      "icon": Icons.music_note,
      "color": primaryColor,
      "sounds": [
        {
          "name": "Singing Bowls",
          "duration": "40 min",
          "image": "https://picsum.photos/100/100?random=5&keyword=bowl",
          "isPlaying": false,
          "isFavorite": true,
        },
        {
          "name": "Crystal Tones",
          "duration": "35 min",
          "image": "https://picsum.photos/100/100?random=6&keyword=crystal",
          "isPlaying": false,
          "isFavorite": false,
        },
        {
          "name": "Space Ambient",
          "duration": "55 min",
          "image": "https://picsum.photos/100/100?random=7&keyword=space",
          "isPlaying": false,
          "isFavorite": true,
        },
        {
          "name": "Healing Frequencies",
          "duration": "25 min",
          "image": "https://picsum.photos/100/100?random=8&keyword=healing",
          "isPlaying": false,
          "isFavorite": false,
        },
      ],
    },
    {
      "title": "Urban",
      "icon": Icons.location_city,
      "color": infoColor,
      "sounds": [
        {
          "name": "Coffee Shop",
          "duration": "90 min",
          "image": "https://picsum.photos/100/100?random=9&keyword=coffee",
          "isPlaying": false,
          "isFavorite": true,
        },
        {
          "name": "Library Ambience",
          "duration": "120 min",
          "image": "https://picsum.photos/100/100?random=10&keyword=library",
          "isPlaying": false,
          "isFavorite": false,
        },
        {
          "name": "City Park",
          "duration": "75 min",
          "image": "https://picsum.photos/100/100?random=11&keyword=park",
          "isPlaying": false,
          "isFavorite": true,
        },
        {
          "name": "Night Traffic",
          "duration": "60 min",
          "image": "https://picsum.photos/100/100?random=12&keyword=night",
          "isPlaying": false,
          "isFavorite": false,
        },
      ],
    },
    {
      "title": "Instruments",
      "icon": Icons.piano,
      "color": warningColor,
      "sounds": [
        {
          "name": "Tibetan Bells",
          "duration": "30 min",
          "image": "https://picsum.photos/100/100?random=13&keyword=bell",
          "isPlaying": false,
          "isFavorite": true,
        },
        {
          "name": "Flute Meditation",
          "duration": "45 min",
          "image": "https://picsum.photos/100/100?random=14&keyword=flute",
          "isPlaying": false,
          "isFavorite": false,
        },
        {
          "name": "Piano Ambient",
          "duration": "50 min",
          "image": "https://picsum.photos/100/100?random=15&keyword=piano",
          "isPlaying": false,
          "isFavorite": true,
        },
        {
          "name": "Guitar Meditation",
          "duration": "40 min",
          "image": "https://picsum.photos/100/100?random=16&keyword=guitar",
          "isPlaying": false,
          "isFavorite": false,
        },
      ],
    },
  ];

  List<Map<String, dynamic>> mixTemplates = [
    {
      "name": "Deep Sleep",
      "description": "Perfect for bedtime relaxation",
      "sounds": ["Rain Forest", "Singing Bowls"],
      "duration": "8 hours",
      "color": primaryColor,
    },
    {
      "name": "Focus Zone",
      "description": "Enhance concentration and productivity",
      "sounds": ["Coffee Shop", "Crystal Tones"],
      "duration": "2 hours",
      "color": infoColor,
    },
    {
      "name": "Stress Relief",
      "description": "Calm your mind and body",
      "sounds": ["Ocean Waves", "Tibetan Bells"],
      "duration": "30 min",
      "color": successColor,
    },
    {
      "name": "Creative Flow",
      "description": "Inspire creativity and innovation",
      "sounds": ["Space Ambient", "Piano Ambient"],
      "duration": "90 min",
      "color": warningColor,
    },
  ];

  int selectedCategoryIndex = 0;
  bool isPlaying = false;
  String currentlyPlaying = "Thunderstorm";
  double volume = 0.7;

  void _toggleSound(String soundName, int categoryIndex, int soundIndex) {
    setState(() {
      // Stop all sounds first
      for (var category in soundCategories) {
        for (var sound in category["sounds"] as List) {
          sound["isPlaying"] = false;
        }
      }
      
      // Toggle the selected sound
      var sound = soundCategories[categoryIndex]["sounds"][soundIndex];
      sound["isPlaying"] = !sound["isPlaying"];
      
      if (sound["isPlaying"]) {
        isPlaying = true;
        currentlyPlaying = soundName;
      } else {
        isPlaying = false;
        currentlyPlaying = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ambient Sounds"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.timer),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Column(
        children: [
          // Current Player
          if (isPlaying)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                border: Border(
                  bottom: BorderSide(
                    color: primaryColor.withAlpha(30),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.volume_up,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Now Playing",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              currentlyPlaying,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        spacing: spSm,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [shadowSm],
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPlaying = false;
                                  for (var category in soundCategories) {
                                    for (var sound in category["sounds"] as List) {
                                      sound["isPlaying"] = false;
                                    }
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.pause,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [shadowSm],
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPlaying = false;
                                  currentlyPlaying = "";
                                  for (var category in soundCategories) {
                                    for (var sound in category["sounds"] as List) {
                                      sound["isPlaying"] = false;
                                    }
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.stop,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  // Volume Control
                  Row(
                    children: [
                      Icon(
                        Icons.volume_down,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: primaryColor,
                            inactiveTrackColor: disabledColor,
                            thumbColor: primaryColor,
                            trackHeight: 3,
                          ),
                          child: Slider(
                            value: volume,
                            onChanged: (value) {
                              setState(() {
                                volume = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Icon(
                        Icons.volume_up,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Mix Templates
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Popular Mixes",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QHorizontalScroll(
                  children: mixTemplates.map((mix) {
                    return Container(
                      width: 200,
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: (mix["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: (mix["color"] as Color).withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${mix["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: mix["color"] as Color,
                                ),
                              ),
                              Text(
                                "${mix["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${mix["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(mix["sounds"] as List).join(" + ")}",
                            style: TextStyle(
                              fontSize: 11,
                              color: mix["color"] as Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Play Mix",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Category Tabs
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QHorizontalScroll(
              children: soundCategories.asMap().entries.map((entry) {
                int index = entry.key;
                var category = entry.value;
                bool isSelected = selectedCategoryIndex == index;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? (category["color"] as Color).withAlpha(20)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected 
                            ? category["color"] as Color
                            : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      spacing: spXs,
                      children: [
                        Icon(
                          category["icon"] as IconData,
                          color: isSelected 
                              ? category["color"] as Color
                              : disabledBoldColor,
                          size: 16,
                        ),
                        Text(
                          "${category["title"]}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected 
                                ? category["color"] as Color
                                : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Sound Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: (soundCategories[selectedCategoryIndex]["sounds"] as List)
                    .asMap()
                    .entries
                    .map((entry) {
                  int soundIndex = entry.key;
                  var sound = entry.value;
                  bool isSoundPlaying = sound["isPlaying"] as bool;
                  bool isFavorite = sound["isFavorite"] as bool;
                  
                  return GestureDetector(
                    onTap: () {
                      _toggleSound(sound["name"], selectedCategoryIndex, soundIndex);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: Border.all(
                          color: isSoundPlaying 
                              ? primaryColor
                              : disabledOutlineBorderColor,
                          width: isSoundPlaying ? 2 : 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                "${sound["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withAlpha(150),
                                  ],
                                ),
                              ),
                            ),
                            
                            // Favorite Icon
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sound["isFavorite"] = !sound["isFavorite"];
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(200),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? dangerColor : disabledBoldColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Play Button
                            Center(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isSoundPlaying 
                                      ? dangerColor.withAlpha(200)
                                      : Colors.white.withAlpha(200),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isSoundPlaying ? Icons.pause : Icons.play_arrow,
                                  color: isSoundPlaying ? Colors.white : primaryColor,
                                  size: 24,
                                ),
                              ),
                            ),
                            
                            // Sound Info
                            Positioned(
                              bottom: spSm,
                              left: spSm,
                              right: spSm,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${sound["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "${sound["duration"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withAlpha(200),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Playing Indicator
                            if (isSoundPlaying)
                              Positioned(
                                top: spSm,
                                left: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "PLAYING",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
