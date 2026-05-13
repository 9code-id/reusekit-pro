import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaSlideshowView extends StatefulWidget {
  const PpaSlideshowView({super.key});

  @override
  State<PpaSlideshowView> createState() => _PpaSlideshowViewState();
}

class _PpaSlideshowViewState extends State<PpaSlideshowView> {
  bool isPlaying = false;
  bool showControls = true;
  int currentSlideIndex = 0;
  int slideInterval = 3;
  String transitionEffect = "fade";
  bool loopEnabled = true;
  bool shuffleEnabled = false;
  bool showCaptions = true;
  
  Timer? slideshowTimer;
  
  List<Map<String, dynamic>> slideIntervals = [
    {"value": 1, "label": "1 second"},
    {"value": 2, "label": "2 seconds"},
    {"value": 3, "label": "3 seconds"},
    {"value": 5, "label": "5 seconds"},
    {"value": 10, "label": "10 seconds"},
    {"value": 15, "label": "15 seconds"},
  ];
  
  List<Map<String, dynamic>> transitionEffects = [
    {"id": "fade", "label": "Fade", "icon": Icons.gradient},
    {"id": "slide", "label": "Slide", "icon": Icons.swipe},
    {"id": "zoom", "label": "Zoom", "icon": Icons.zoom_in},
    {"id": "flip", "label": "Flip", "icon": Icons.flip},
  ];

  List<Map<String, dynamic>> photos = [
    {
      "id": "1",
      "url": "https://picsum.photos/800/600?random=1&keyword=landscape",
      "title": "Mountain Vista",
      "caption": "Breathtaking mountain landscape captured during golden hour",
      "date": "2024-03-15"
    },
    {
      "id": "2",
      "url": "https://picsum.photos/800/600?random=2&keyword=sunset",
      "title": "Ocean Sunset",
      "caption": "Peaceful sunset over calm ocean waters",
      "date": "2024-03-14"
    },
    {
      "id": "3",
      "url": "https://picsum.photos/800/600?random=3&keyword=nature",
      "title": "Forest Path",
      "caption": "Mystical forest path in autumn colors",
      "date": "2024-03-13"
    },
    {
      "id": "4",
      "url": "https://picsum.photos/800/600?random=4&keyword=city",
      "title": "City Lights",
      "caption": "Urban cityscape illuminated at night",
      "date": "2024-03-12"
    },
    {
      "id": "5",
      "url": "https://picsum.photos/800/600?random=5&keyword=architecture",
      "title": "Modern Architecture",
      "caption": "Contemporary building with unique design",
      "date": "2024-03-11"
    },
    {
      "id": "6",
      "url": "https://picsum.photos/800/600?random=6&keyword=food",
      "title": "Gourmet Cuisine",
      "caption": "Artfully plated gourmet dish",
      "date": "2024-03-10"
    },
    {
      "id": "7",
      "url": "https://picsum.photos/800/600?random=7&keyword=travel",
      "title": "Travel Adventure",
      "caption": "Memorable moments from recent travels",
      "date": "2024-03-09"
    },
    {
      "id": "8",
      "url": "https://picsum.photos/800/600?random=8&keyword=portrait",
      "title": "Portrait Study",
      "caption": "Artistic portrait with dramatic lighting",
      "date": "2024-03-08"
    }
  ];

  @override
  void dispose() {
    slideshowTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPhoto = photos[currentSlideIndex];
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          showControls = !showControls;
          setState(() {});
        },
        child: Stack(
          children: [
            // Main Slideshow Display
            Center(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  switch (transitionEffect) {
                    case "slide":
                      return SlideTransition(
                        position: animation.drive(
                          Tween(begin: Offset(1.0, 0.0), end: Offset.zero),
                        ),
                        child: child,
                      );
                    case "zoom":
                      return ScaleTransition(scale: animation, child: child);
                    case "flip":
                      return RotationTransition(turns: animation, child: child);
                    default:
                      return FadeTransition(opacity: animation, child: child);
                  }
                },
                child: Container(
                  key: ValueKey(currentSlideIndex),
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(
                    "${currentPhoto["url"]}",
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / 
                                loadingProgress.expectedTotalBytes!
                              : null,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Top Controls
            if (showControls)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + spSm,
                    left: spMd,
                    right: spMd,
                    bottom: spMd,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withAlpha(200),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _stopSlideshow();
                          back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Slideshow",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${currentSlideIndex + 1} of ${photos.length}",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              shuffleEnabled = !shuffleEnabled;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: shuffleEnabled ? primaryColor : Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.shuffle,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () {
                              loopEnabled = !loopEnabled;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: loopEnabled ? primaryColor : Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.repeat,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () {
                              _showSlideshowSettings();
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            // Caption
            if (showControls && showCaptions)
              Positioned(
                bottom: 120,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${currentPhoto["title"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${currentPhoto["caption"]}",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${currentPhoto["date"]}",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

            // Bottom Controls
            if (showControls)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    left: spMd,
                    right: spMd,
                    top: spMd,
                    bottom: MediaQuery.of(context).padding.bottom + spMd,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withAlpha(200),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Progress Bar
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: LinearProgressIndicator(
                          value: (currentSlideIndex + 1) / photos.length,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Control Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _previousSlide();
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          
                          GestureDetector(
                            onTap: () {
                              if (isPlaying) {
                                _pauseSlideshow();
                              } else {
                                _startSlideshow();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                          
                          GestureDetector(
                            onTap: () {
                              _nextSlide();
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.skip_next,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Photo Thumbnails
                      Container(
                        height: 60,
                        child: QHorizontalScroll(
                          children: List.generate(photos.length, (index) {
                            final photo = photos[index];
                            final isSelected = index == currentSlideIndex;
                            return GestureDetector(
                              onTap: () {
                                currentSlideIndex = index;
                                setState(() {});
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                margin: EdgeInsets.only(
                                  right: index < photos.length - 1 ? spXs : 0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${photo["url"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Slideshow Status Indicator
            if (isPlaying)
              Positioned(
                top: MediaQuery.of(context).padding.top + 60,
                left: spMd,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.play_circle_filled,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "PLAYING",
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
          ],
        ),
      ),
    );
  }

  void _startSlideshow() {
    isPlaying = true;
    setState(() {});
    
    slideshowTimer = Timer.periodic(Duration(seconds: slideInterval), (timer) {
      _nextSlide();
    });
  }

  void _pauseSlideshow() {
    isPlaying = false;
    slideshowTimer?.cancel();
    setState(() {});
  }

  void _stopSlideshow() {
    isPlaying = false;
    slideshowTimer?.cancel();
    setState(() {});
  }

  void _nextSlide() {
    if (shuffleEnabled) {
      int nextIndex;
      do {
        nextIndex = Math.Random().nextInt(photos.length);
      } while (nextIndex == currentSlideIndex && photos.length > 1);
      currentSlideIndex = nextIndex;
    } else {
      if (currentSlideIndex < photos.length - 1) {
        currentSlideIndex++;
      } else if (loopEnabled) {
        currentSlideIndex = 0;
      } else {
        _pauseSlideshow();
        return;
      }
    }
    setState(() {});
  }

  void _previousSlide() {
    if (currentSlideIndex > 0) {
      currentSlideIndex--;
    } else if (loopEnabled) {
      currentSlideIndex = photos.length - 1;
    }
    setState(() {});
  }

  void _showSlideshowSettings() {
    _pauseSlideshow();
    
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
            Text(
              "Slideshow Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            // Slide Interval
            QDropdownField(
              label: "Slide Interval",
              items: slideIntervals.map((interval) => {
                "label": interval["label"],
                "value": interval["value"]
              }).toList(),
              value: slideInterval,
              onChanged: (value, label) {
                slideInterval = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            
            // Transition Effect
            Text(
              "Transition Effect",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              spacing: spSm,
              children: transitionEffects.map((effect) {
                final isSelected = transitionEffect == effect["id"];
                return GestureDetector(
                  onTap: () {
                    transitionEffect = effect["id"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          effect["icon"],
                          color: isSelected ? primaryColor : disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${effect["label"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? primaryColor : disabledBoldColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        Spacer(),
                        if (isSelected)
                          Icon(
                            Icons.check,
                            color: primaryColor,
                            size: 16,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spSm),
            
            // Show Captions Toggle
            Row(
              children: [
                Icon(
                  Icons.closed_caption,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Show Captions",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                Switch(
                  value: showCaptions,
                  onChanged: (value) {
                    showCaptions = value;
                    setState(() {});
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Settings",
                size: bs.md,
                onPressed: () {
                  back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
