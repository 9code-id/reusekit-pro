import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMeditation2View extends StatefulWidget {
  @override
  State<GrlMeditation2View> createState() => _GrlMeditation2ViewState();
}

class _GrlMeditation2ViewState extends State<GrlMeditation2View> {
  bool isPlaying = false;
  bool isLooping = false;
  double currentPosition = 0.45;
  double volume = 0.8;

  Map<String, dynamic> currentSession = {
    "title": "Ocean Waves Meditation",
    "instructor": "Sarah Chen",
    "duration": "20:00",
    "currentTime": "09:12",
    "category": "Sleep",
    "image": "https://picsum.photos/400/400?random=1&keyword=ocean",
    "description": "Let the rhythmic sounds of ocean waves carry you into deep relaxation",
  };

  List<Map<String, dynamic>> backgroundSounds = [
    {
      "name": "Ocean Waves",
      "icon": Icons.waves,
      "isActive": true,
      "volume": 0.8,
      "color": infoColor,
    },
    {
      "name": "Rain Forest",
      "icon": Icons.forest,
      "isActive": false,
      "volume": 0.6,
      "color": successColor,
    },
    {
      "name": "White Noise",
      "icon": Icons.graphic_eq,
      "isActive": false,
      "volume": 0.5,
      "color": disabledBoldColor,
    },
    {
      "name": "Fireplace",
      "icon": Icons.local_fire_department,
      "isActive": false,
      "volume": 0.7,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> relatedSessions = [
    {
      "title": "Deep Sleep Journey",
      "instructor": "Michael Torres",
      "duration": "25 min",
      "image": "https://picsum.photos/100/100?random=2&keyword=sleep",
    },
    {
      "title": "Mountain Breeze",
      "instructor": "Emma Wilson",
      "duration": "15 min", 
      "image": "https://picsum.photos/100/100?random=3&keyword=mountain",
    },
    {
      "title": "Night Rain",
      "instructor": "David Park",
      "duration": "30 min",
      "image": "https://picsum.photos/100/100?random=4&keyword=rain",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("Now Playing"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withAlpha(100),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${currentSession["image"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: spLg),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(currentSession["category"] as String).withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${currentSession["category"]}",
                      style: TextStyle(
                        color: _getCategoryColor(currentSession["category"] as String),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${currentSession["title"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "by ${currentSession["instructor"]}",
                    style: TextStyle(
                      color: Colors.white.withAlpha(180),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spLg),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${currentSession["currentTime"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${currentSession["duration"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: primaryColor,
                            inactiveTrackColor: Colors.white.withAlpha(50),
                            thumbColor: primaryColor,
                            trackHeight: 4,
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
                  ),
                  SizedBox(height: spLg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.replay_10, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spMd),
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
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
                      SizedBox(width: spMd),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.forward_30, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          isLooping = !isLooping;
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.loop,
                              color: isLooping ? primaryColor : Colors.white.withAlpha(100),
                              size: 24,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Loop",
                              style: TextStyle(
                                color: isLooping ? primaryColor : Colors.white.withAlpha(100),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.volume_up,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Volume",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.white.withAlpha(100),
                              size: 24,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Timer",
                              style: TextStyle(
                                color: Colors.white.withAlpha(100),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white.withAlpha(50),
                      thumbColor: Colors.white,
                      trackHeight: 2,
                    ),
                    child: Slider(
                      value: volume,
                      onChanged: (value) {
                        volume = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: spLg),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.music_note, color: Colors.white, size: 20),
                            SizedBox(width: spSm),
                            Text(
                              "Background Sounds",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        ...List.generate(backgroundSounds.length, (index) {
                          final sound = backgroundSounds[index];
                          final isActive = sound["isActive"] as bool;
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isActive 
                                        ? (sound["color"] as Color).withAlpha(50)
                                        : Colors.white.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    sound["icon"] as IconData,
                                    color: isActive ? sound["color"] as Color : Colors.white.withAlpha(100),
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Text(
                                    "${sound["name"]}",
                                    style: TextStyle(
                                      color: isActive ? Colors.white : Colors.white.withAlpha(180),
                                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                if (isActive) ...[
                                  Container(
                                    width: 80,
                                    child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor: sound["color"] as Color,
                                        inactiveTrackColor: Colors.white.withAlpha(50),
                                        thumbColor: sound["color"] as Color,
                                        trackHeight: 2,
                                      ),
                                      child: Slider(
                                        value: sound["volume"] as double,
                                        onChanged: (value) {
                                          backgroundSounds[index]["volume"] = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                                Switch(
                                  value: isActive,
                                  activeColor: sound["color"] as Color,
                                  onChanged: (value) {
                                    backgroundSounds[index]["isActive"] = value;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: spLg),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Related Sessions",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        ...List.generate(relatedSessions.length, (index) {
                          final session = relatedSessions[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${session["image"]}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${session["title"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "by ${session["instructor"]} • ${session["duration"]}",
                                        style: TextStyle(
                                          color: Colors.white.withAlpha(180),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.play_arrow, color: Colors.white),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
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

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'sleep':
        return infoColor;
      case 'anxiety':
        return dangerColor;
      case 'focus':
        return warningColor;
      case 'mindfulness':
        return successColor;
      default:
        return primaryColor;
    }
  }
}
