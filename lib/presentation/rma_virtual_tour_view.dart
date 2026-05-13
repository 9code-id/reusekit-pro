import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaVirtualTourView extends StatefulWidget {
  const RmaVirtualTourView({super.key});

  @override
  State<RmaVirtualTourView> createState() => _RmaVirtualTourViewState();
}

class _RmaVirtualTourViewState extends State<RmaVirtualTourView> {
  int currentRoomIndex = 0;
  bool isPlaying = false;
  bool isFullscreen = false;
  bool showControls = true;
  bool isMuted = false;
  double currentProgress = 0.0;
  int currentFloor = 1;

  List<Map<String, dynamic>> rooms = [
    {
      "id": 1,
      "name": "Front Entrance",
      "floor": 1,
      "description": "Welcome to this beautiful property. Notice the elegant front door and spacious entryway.",
      "duration": "2:30",
      "thumbnail": "https://picsum.photos/400/300?random=1&keyword=entrance",
      "tourUrl": "https://picsum.photos/800/600?random=1&keyword=entrance",
      "hotspots": [
        {"x": 0.3, "y": 0.5, "room": "Living Room", "description": "Enter the living room"},
        {"x": 0.7, "y": 0.4, "room": "Dining Room", "description": "View the dining area"},
      ],
    },
    {
      "id": 2,
      "name": "Living Room",
      "floor": 1,
      "description": "Spacious living room with natural lighting and modern furnishings.",
      "duration": "3:15",
      "thumbnail": "https://picsum.photos/400/300?random=2&keyword=living",
      "tourUrl": "https://picsum.photos/800/600?random=2&keyword=living",
      "hotspots": [
        {"x": 0.2, "y": 0.6, "room": "Kitchen", "description": "Step into the kitchen"},
        {"x": 0.8, "y": 0.3, "room": "Dining Room", "description": "View dining area"},
      ],
    },
    {
      "id": 3,
      "name": "Kitchen",
      "floor": 1,
      "description": "Modern kitchen with granite countertops and stainless steel appliances.",
      "duration": "2:45",
      "thumbnail": "https://picsum.photos/400/300?random=3&keyword=kitchen",
      "tourUrl": "https://picsum.photos/800/600?random=3&keyword=kitchen",
      "hotspots": [
        {"x": 0.5, "y": 0.7, "room": "Dining Room", "description": "Adjacent dining room"},
        {"x": 0.1, "y": 0.4, "room": "Pantry", "description": "Storage pantry"},
      ],
    },
    {
      "id": 4,
      "name": "Dining Room",
      "floor": 1,
      "description": "Elegant dining room perfect for entertaining guests.",
      "duration": "2:00",
      "thumbnail": "https://picsum.photos/400/300?random=4&keyword=dining",
      "tourUrl": "https://picsum.photos/800/600?random=4&keyword=dining",
      "hotspots": [
        {"x": 0.4, "y": 0.3, "room": "Living Room", "description": "Return to living room"},
        {"x": 0.6, "y": 0.5, "room": "Kitchen", "description": "Enter kitchen"},
      ],
    },
    {
      "id": 5,
      "name": "Master Bedroom",
      "floor": 2,
      "description": "Spacious master bedroom with walk-in closet and en-suite bathroom.",
      "duration": "3:30",
      "thumbnail": "https://picsum.photos/400/300?random=5&keyword=bedroom",
      "tourUrl": "https://picsum.photos/800/600?random=5&keyword=bedroom",
      "hotspots": [
        {"x": 0.2, "y": 0.4, "room": "Master Bathroom", "description": "Private bathroom"},
        {"x": 0.8, "y": 0.6, "room": "Walk-in Closet", "description": "Spacious closet"},
      ],
    },
    {
      "id": 6,
      "name": "Master Bathroom",
      "floor": 2,
      "description": "Luxurious bathroom with marble finishes and spa-like amenities.",
      "duration": "2:20",
      "thumbnail": "https://picsum.photos/400/300?random=6&keyword=bathroom",
      "tourUrl": "https://picsum.photos/800/600?random=6&keyword=bathroom",
      "hotspots": [
        {"x": 0.5, "y": 0.8, "room": "Master Bedroom", "description": "Back to bedroom"},
      ],
    },
  ];

  List<Map<String, dynamic>> tourFeatures = [
    {"icon": Icons.view_in_ar, "label": "360° View", "active": true},
    {"icon": Icons.music_note, "label": "Audio Guide", "active": true},
    {"icon": Icons.location_on, "label": "Hotspots", "active": true},
    {"icon": Icons.map, "label": "Floor Plan", "active": false},
    {"icon": Icons.fullscreen, "label": "VR Mode", "active": false},
  ];

  Map<String, dynamic> get currentRoom => rooms[currentRoomIndex];

  List<Map<String, dynamic>> get currentFloorRooms {
    return rooms.where((room) => room["floor"] == currentFloor).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isFullscreen
          ? null
          : AppBar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              title: Text("Virtual Tour"),
              actions: [
                IconButton(
                  icon: Icon(Icons.fullscreen),
                  onPressed: () {
                    isFullscreen = true;
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    ss("Virtual tour shared successfully");
                  },
                ),
              ],
            ),
      body: Stack(
        children: [
          // Main Tour View
          GestureDetector(
            onTap: () {
              showControls = !showControls;
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  // 360° Tour Image
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      "${currentRoom["tourUrl"]}",
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Hotspots
                  ...((currentRoom["hotspots"] as List? ?? []).map((hotspot) {
                    return Positioned(
                      left: (hotspot["x"] as double) * MediaQuery.of(context).size.width - 20,
                      top: (hotspot["y"] as double) * MediaQuery.of(context).size.height - 20,
                      child: GestureDetector(
                        onTap: () {
                          _showHotspotInfo(hotspot);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [shadowMd],
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  }).toList()),

                  // Fullscreen Exit
                  if (isFullscreen)
                    Positioned(
                      top: 40,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          isFullscreen = false;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.fullscreen_exit,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Controls Overlay
          if (showControls && !isFullscreen) ...[
            // Bottom Controls
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(200),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    // Progress Bar
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd),
                      child: Row(
                        children: [
                          Text(
                            "1:30",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: primaryColor,
                                inactiveTrackColor: Colors.white.withAlpha(100),
                                thumbColor: primaryColor,
                                trackHeight: 3,
                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                              ),
                              child: Slider(
                                value: currentProgress,
                                onChanged: (value) {
                                  currentProgress = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${currentRoom["duration"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Room Info and Controls
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${currentRoom["name"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${currentRoom["description"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withAlpha(200),
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spMd),
                              // Play/Pause Button
                              GestureDetector(
                                onTap: () {
                                  isPlaying = !isPlaying;
                                  setState(() {});
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spMd),

                          // Control Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildControlButton(
                                icon: Icons.skip_previous,
                                label: "Previous",
                                onTap: () {
                                  if (currentRoomIndex > 0) {
                                    currentRoomIndex--;
                                    setState(() {});
                                  }
                                },
                                enabled: currentRoomIndex > 0,
                              ),
                              _buildControlButton(
                                icon: isMuted ? Icons.volume_off : Icons.volume_up,
                                label: "Audio",
                                onTap: () {
                                  isMuted = !isMuted;
                                  setState(() {});
                                },
                              ),
                              _buildControlButton(
                                icon: Icons.view_in_ar,
                                label: "360°",
                                onTap: () {
                                  ss("360° mode activated");
                                },
                              ),
                              _buildControlButton(
                                icon: Icons.skip_next,
                                label: "Next",
                                onTap: () {
                                  if (currentRoomIndex < rooms.length - 1) {
                                    currentRoomIndex++;
                                    setState(() {});
                                  }
                                },
                                enabled: currentRoomIndex < rooms.length - 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Top Floor Selector
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(150),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        currentFloor = 1;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: currentFloor == 1 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Floor 1",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    GestureDetector(
                      onTap: () {
                        currentFloor = 2;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: currentFloor == 2 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Floor 2",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Room List (Side Panel)
          if (!isFullscreen)
            Positioned(
              top: 100,
              right: 20,
              child: Container(
                width: 200,
                constraints: BoxConstraints(maxHeight: 400),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(200),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Text(
                        "Floor ${currentFloor} Rooms",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: currentFloorRooms.map((room) {
                            bool isSelected = room["id"] == currentRoom["id"];
                            return GestureDetector(
                              onTap: () {
                                currentRoomIndex = rooms.indexOf(room);
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor.withAlpha(150) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 30,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(radiusXs),
                                        child: Image.network(
                                          "${room["thumbnail"]}",
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
                                            "${room["name"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "${room["duration"]}",
                                            style: TextStyle(
                                              color: Colors.white.withAlpha(150),
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
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

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: enabled ? Colors.white.withAlpha(200) : Colors.white.withAlpha(100),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: enabled ? Colors.black : disabledColor,
              size: 20,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              color: enabled ? Colors.white : disabledColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showHotspotInfo(Map<String, dynamic> hotspot) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.room,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${hotspot["room"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "${hotspot["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Go to ${hotspot["room"]}",
                size: bs.md,
                onPressed: () {
                  Navigator.pop(context);
                  // Find room and navigate
                  int roomIndex = rooms.indexWhere((room) => room["name"] == hotspot["room"]);
                  if (roomIndex != -1) {
                    currentRoomIndex = roomIndex;
                    setState(() {});
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
