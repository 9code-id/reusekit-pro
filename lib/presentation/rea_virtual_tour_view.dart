import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaVirtualTourView extends StatefulWidget {
  const ReaVirtualTourView({super.key});

  @override
  State<ReaVirtualTourView> createState() => _ReaVirtualTourViewState();
}

class _ReaVirtualTourViewState extends State<ReaVirtualTourView> {
  int currentTourIndex = 0;
  bool isFullscreen = false;
  bool isPlaying = false;
  bool showControls = true;
  double tourProgress = 0.3;

  // Sample tour data
  final List<Map<String, dynamic>> tourSpots = [
    {
      "id": 1,
      "name": "Living Room",
      "description": "Spacious living area with modern furnishing",
      "image": "https://picsum.photos/800/600?random=1&keyword=livingroom",
      "duration": "2:30",
      "isCompleted": true,
    },
    {
      "id": 2,
      "name": "Kitchen",
      "description": "Fully equipped modern kitchen with island",
      "image": "https://picsum.photos/800/600?random=2&keyword=kitchen",
      "duration": "1:45",
      "isCompleted": true,
    },
    {
      "id": 3,
      "name": "Master Bedroom",
      "description": "Large bedroom with walk-in closet",
      "image": "https://picsum.photos/800/600?random=3&keyword=bedroom",
      "duration": "2:00",
      "isCompleted": false,
    },
    {
      "id": 4,
      "name": "Bathroom",
      "description": "Luxury bathroom with marble finishes",
      "image": "https://picsum.photos/800/600?random=4&keyword=bathroom",
      "duration": "1:20",
      "isCompleted": false,
    },
    {
      "id": 5,
      "name": "Garden",
      "description": "Beautiful landscaped garden with patio",
      "image": "https://picsum.photos/800/600?random=5&keyword=garden",
      "duration": "1:50",
      "isCompleted": false,
    },
  ];

  final List<Map<String, dynamic>> tourFeatures = [
    {
      "icon": Icons.threesixty,
      "title": "360° View",
      "description": "Full panoramic views of every room",
    },
    {
      "icon": Icons.hd,
      "title": "HD Quality",
      "description": "Crystal clear high-definition visuals",
    },
    {
      "icon": Icons.mic,
      "title": "Audio Guide",
      "description": "Professional commentary throughout",
    },
    {
      "icon": Icons.zoom_in,
      "title": "Zoom & Pan",
      "description": "Explore every detail up close",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isFullscreen
          ? null
          : AppBar(
              title: Text("Virtual Tour"),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              actions: [
                IconButton(
                  icon: Icon(Icons.fullscreen),
                  onPressed: _toggleFullscreen,
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: _shareTour,
                ),
              ],
            ),
      body: Stack(
        children: [
          // Main tour viewer
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("${tourSpots[currentTourIndex]["image"]}"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(30),
                      Colors.transparent,
                      Colors.black.withAlpha(80),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Tour controls
          if (showControls) ...[
            // Top info bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(150),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${currentTourIndex + 1}/${tourSpots.length}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${tourSpots[currentTourIndex]["duration"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${tourSpots[currentTourIndex]["name"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${tourSpots[currentTourIndex]["description"]}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Progress bar
            Positioned(
              bottom: isFullscreen ? 120 : 160,
              left: spMd,
              right: spMd,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: tourProgress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom controls
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withAlpha(150),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      // Playback controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.skip_previous,
                              color: currentTourIndex > 0
                                  ? Colors.white
                                  : Colors.white.withAlpha(100),
                            ),
                            onPressed: currentTourIndex > 0 ? _previousSpot : null,
                          ),
                          SizedBox(width: spSm),
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                              onPressed: _togglePlayback,
                            ),
                          ),
                          SizedBox(width: spSm),
                          IconButton(
                            icon: Icon(
                              Icons.skip_next,
                              color: currentTourIndex < tourSpots.length - 1
                                  ? Colors.white
                                  : Colors.white.withAlpha(100),
                            ),
                            onPressed: currentTourIndex < tourSpots.length - 1
                                ? _nextSpot
                                : null,
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Tour spots list
                      Container(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tourSpots.length,
                          itemBuilder: (context, index) {
                            final spot = tourSpots[index];
                            final isActive = index == currentTourIndex;
                            final isCompleted = spot["isCompleted"] as bool;

                            return GestureDetector(
                              onTap: () => _selectSpot(index),
                              child: Container(
                                width: 60,
                                margin: EdgeInsets.only(right: spSm),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(radiusSm),
                                        border: Border.all(
                                          color: isActive
                                              ? primaryColor
                                              : Colors.white.withAlpha(100),
                                          width: isActive ? 2 : 1,
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage("${spot["image"]}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: isCompleted
                                          ? Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black.withAlpha(100),
                                                borderRadius: BorderRadius.circular(radiusSm),
                                              ),
                                              child: Icon(
                                                Icons.check_circle,
                                                color: successColor,
                                                size: 20,
                                              ),
                                            )
                                          : null,
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${spot["name"]}",
                                      style: TextStyle(
                                        color: isActive
                                            ? Colors.white
                                            : Colors.white.withAlpha(150),
                                        fontSize: 10,
                                        fontWeight: isActive
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
              ),
            ),

            // Features overlay
            Positioned(
              top: 100,
              right: spMd,
              child: Column(
                children: [
                  _buildFeatureButton(Icons.threesixty, "360°"),
                  SizedBox(height: spSm),
                  _buildFeatureButton(Icons.zoom_in, "Zoom"),
                  SizedBox(height: spSm),
                  _buildFeatureButton(Icons.mic, "Audio"),
                  SizedBox(height: spSm),
                  _buildFeatureButton(Icons.info_outline, "Info"),
                ],
              ),
            ),
          ],

          // Tap to toggle controls
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleControls,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: !isFullscreen
          ? Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowMd],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Virtual Tour Features",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Interactive 360° property exploration",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Full Screen",
                        size: bs.sm,
                        onPressed: _toggleFullscreen,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: tourFeatures.map((feature) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: spXs),
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                feature["icon"] as IconData,
                                color: primaryColor,
                                size: 16,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${feature["title"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildFeatureButton(IconData icon, String label) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(150),
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          if (label.isNotEmpty) ...[
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _toggleFullscreen() {
    setState(() {
      isFullscreen = !isFullscreen;
    });
  }

  void _toggleControls() {
    setState(() {
      showControls = !showControls;
    });
  }

  void _togglePlayback() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _previousSpot() {
    if (currentTourIndex > 0) {
      setState(() {
        currentTourIndex--;
        tourProgress = 0.0;
      });
    }
  }

  void _nextSpot() {
    if (currentTourIndex < tourSpots.length - 1) {
      setState(() {
        currentTourIndex++;
        tourProgress = 0.0;
      });
    }
  }

  void _selectSpot(int index) {
    setState(() {
      currentTourIndex = index;
      tourProgress = 0.0;
    });
  }

  void _shareTour() {
    ss("Virtual tour link shared successfully!");
  }
}
