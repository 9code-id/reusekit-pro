import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaSlideshowView extends StatefulWidget {
  const NmaSlideshowView({super.key});

  @override
  State<NmaSlideshowView> createState() => _NmaSlideshowViewState();
}

class _NmaSlideshowViewState extends State<NmaSlideshowView> {
  int currentSlide = 0;
  bool isPlaying = false;
  bool isFullscreen = false;
  double transitionDuration = 3.0;
  String transitionEffect = "fade";
  bool showThumbnails = true;
  bool autoAdvance = true;
  bool loopSlideshow = true;
  bool showProgressBar = true;

  List<Map<String, dynamic>> slideshowImages = [
    {
      "id": 1,
      "title": "Mountain Sunrise",
      "description": "Beautiful sunrise over the mountain peaks",
      "image": "https://picsum.photos/800/600?random=1&keyword=mountain",
      "duration": 5,
      "tags": ["nature", "sunrise", "mountain"],
      "createdAt": "2024-01-15",
    },
    {
      "id": 2,
      "title": "Ocean Waves",
      "description": "Peaceful ocean waves at sunset",
      "image": "https://picsum.photos/800/600?random=2&keyword=ocean",
      "duration": 4,
      "tags": ["ocean", "sunset", "waves"],
      "createdAt": "2024-01-14",
    },
    {
      "id": 3,
      "title": "Forest Path",
      "description": "Winding path through autumn forest",
      "image": "https://picsum.photos/800/600?random=3&keyword=forest",
      "duration": 6,
      "tags": ["forest", "autumn", "path"],
      "createdAt": "2024-01-13",
    },
    {
      "id": 4,
      "title": "City Skyline",
      "description": "Modern city skyline at night",
      "image": "https://picsum.photos/800/600?random=4&keyword=city",
      "duration": 3,
      "tags": ["city", "night", "skyline"],
      "createdAt": "2024-01-12",
    },
    {
      "id": 5,
      "title": "Desert Dunes",
      "description": "Golden sand dunes at dawn",
      "image": "https://picsum.photos/800/600?random=5&keyword=desert",
      "duration": 4,
      "tags": ["desert", "dunes", "dawn"],
      "createdAt": "2024-01-11",
    },
    {
      "id": 6,
      "title": "Lake Reflection",
      "description": "Perfect mountain reflection in lake",
      "image": "https://picsum.photos/800/600?random=6&keyword=lake",
      "duration": 5,
      "tags": ["lake", "reflection", "peaceful"],
      "createdAt": "2024-01-10",
    },
  ];

  List<String> transitionEffects = [
    "fade",
    "slide",
    "zoom",
    "dissolve",
  ];

  @override
  void initState() {
    super.initState();
    _startAutoAdvance();
  }

  void _startAutoAdvance() {
    if (autoAdvance && isPlaying) {
      Future.delayed(Duration(seconds: transitionDuration.toInt()), () {
        if (mounted && isPlaying) {
          _nextSlide();
          _startAutoAdvance();
        }
      });
    }
  }

  void _nextSlide() {
    if (currentSlide < slideshowImages.length - 1) {
      currentSlide++;
    } else if (loopSlideshow) {
      currentSlide = 0;
    } else {
      isPlaying = false;
    }
    setState(() {});
  }

  void _previousSlide() {
    if (currentSlide > 0) {
      currentSlide--;
    } else if (loopSlideshow) {
      currentSlide = slideshowImages.length - 1;
    }
    setState(() {});
  }

  void _togglePlayPause() {
    isPlaying = !isPlaying;
    setState(() {});
    if (isPlaying) {
      _startAutoAdvance();
    }
  }

  void _toggleFullscreen() {
    isFullscreen = !isFullscreen;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isFullscreen ? Colors.black : null,
      appBar: isFullscreen
          ? null
          : AppBar(
              title: Text("Photo Slideshow"),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => _showSettingsDialog(),
                ),
                IconButton(
                  icon: Icon(isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
                  onPressed: _toggleFullscreen,
                ),
              ],
            ),
      body: Column(
        children: [
          // Main slideshow area
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                children: [
                  // Current image
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: _togglePlayPause,
                      child: Image.network(
                        "${slideshowImages[currentSlide]["image"]}",
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? (loadingProgress.cumulativeBytesLoaded as double) /
                                      (loadingProgress.expectedTotalBytes as double)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error, size: 48, color: Colors.white54),
                                SizedBox(height: spSm),
                                Text(
                                  "Failed to load image",
                                  style: TextStyle(color: Colors.white54),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Navigation arrows
                  Positioned(
                    left: spMd,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _previousSlide,
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(128),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: spMd,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _nextSlide,
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(128),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Play/Pause overlay
                  if (!isPlaying)
                    Positioned.fill(
                      child: Center(
                        child: GestureDetector(
                          onTap: _togglePlayPause,
                          child: Container(
                            padding: EdgeInsets.all(spLg),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(180),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Progress bar
                  if (showProgressBar && !isFullscreen)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 4,
                        child: LinearProgressIndicator(
                          value: (currentSlide + 1) / slideshowImages.length,
                          backgroundColor: Colors.white.withAlpha(77),
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      ),
                    ),

                  // Image info overlay
                  if (!isFullscreen)
                    Positioned(
                      bottom: spMd,
                      left: spMd,
                      right: spMd,
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(180),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${slideshowImages[currentSlide]["title"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${slideshowImages[currentSlide]["description"]}",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text(
                                  "${currentSlide + 1} of ${slideshowImages.length}",
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                ...((slideshowImages[currentSlide]["tags"] as List).take(3).map((tag) =>
                                    Container(
                                      margin: EdgeInsets.only(left: spXs),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(128),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "#$tag",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Fullscreen controls
                  if (isFullscreen)
                    Positioned(
                      top: spMd,
                      right: spMd,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: _togglePlayPause,
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(128),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: _toggleFullscreen,
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(128),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.fullscreen_exit,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Thumbnails and controls
          if (!isFullscreen) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  // Control buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QButton(
                        icon: Icons.skip_previous,
                        size: bs.sm,
                        onPressed: _previousSlide,
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: isPlaying ? Icons.pause : Icons.play_arrow,
                        size: bs.md,
                        onPressed: _togglePlayPause,
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.skip_next,
                        size: bs.sm,
                        onPressed: _nextSlide,
                      ),
                      SizedBox(width: spLg),
                      QButton(
                        icon: Icons.shuffle,
                        size: bs.sm,
                        color: loopSlideshow ? primaryColor : disabledBoldColor,
                        onPressed: () {
                          loopSlideshow = !loopSlideshow;
                          setState(() {});
                        },
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.settings,
                        size: bs.sm,
                        onPressed: _showSettingsDialog,
                      ),
                    ],
                  ),

                  if (showThumbnails) ...[
                    SizedBox(height: spMd),
                    // Thumbnails
                    Container(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: slideshowImages.length,
                        itemBuilder: (context, index) {
                          final image = slideshowImages[index];
                          final isSelected = index == currentSlide;

                          return GestureDetector(
                            onTap: () {
                              currentSlide = index;
                              setState(() {});
                            },
                            child: Container(
                              width: 100,
                              margin: EdgeInsets.only(right: spSm),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: isSelected ? primaryColor : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      "${image["image"]}",
                                      width: 100,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                    if (isSelected)
                                      Positioned.fill(
                                        child: Container(
                                          color: primaryColor.withAlpha(77),
                                          child: Center(
                                            child: Icon(
                                              Icons.play_circle,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Positioned(
                                      bottom: 4,
                                      right: 4,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withAlpha(180),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Slideshow Settings"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Auto advance
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Auto Advance",
                          "value": true,
                          "checked": autoAdvance,
                        }
                      ],
                      value: [
                        if (autoAdvance)
                          {
                            "label": "Auto Advance",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        autoAdvance = values.isNotEmpty;
                        setDialogState(() {});
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: spMd),

              // Loop slideshow
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Loop Slideshow",
                          "value": true,
                          "checked": loopSlideshow,
                        }
                      ],
                      value: [
                        if (loopSlideshow)
                          {
                            "label": "Loop Slideshow",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        loopSlideshow = values.isNotEmpty;
                        setDialogState(() {});
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: spMd),

              // Show thumbnails
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Show Thumbnails",
                          "value": true,
                          "checked": showThumbnails,
                        }
                      ],
                      value: [
                        if (showThumbnails)
                          {
                            "label": "Show Thumbnails",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        showThumbnails = values.isNotEmpty;
                        setDialogState(() {});
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: spMd),

              // Show progress bar
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Show Progress Bar",
                          "value": true,
                          "checked": showProgressBar,
                        }
                      ],
                      value: [
                        if (showProgressBar)
                          {
                            "label": "Show Progress Bar",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        showProgressBar = values.isNotEmpty;
                        setDialogState(() {});
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: spMd),

              // Transition duration
              Text(
                "Transition Duration: ${transitionDuration.toInt()} seconds",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Slider(
                value: transitionDuration,
                min: 1.0,
                max: 10.0,
                divisions: 9,
                onChanged: (value) {
                  transitionDuration = value;
                  setDialogState(() {});
                  setState(() {});
                },
              ),

              SizedBox(height: spMd),

              // Transition effect
              QDropdownField(
                label: "Transition Effect",
                items: transitionEffects.map((effect) => {
                  "label": effect.toUpperCase(),
                  "value": effect,
                }).toList(),
                value: transitionEffect,
                onChanged: (value, label) {
                  transitionEffect = value;
                  setDialogState(() {});
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        ),
      ),
    );
  }
}
