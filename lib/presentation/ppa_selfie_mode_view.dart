import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaSelfieModeView extends StatefulWidget {
  const PpaSelfieModeView({super.key});

  @override
  State<PpaSelfieModeView> createState() => _PpaSelfieModeViewState();
}

class _PpaSelfieModeViewState extends State<PpaSelfieModeView> {
  bool isCapturing = false;
  bool showCountdown = false;
  int countdown = 0;
  String selectedFilter = "beauty";
  String selectedBeautyLevel = "medium";
  bool isSmileDetectionOn = true;
  bool isBlinkDetectionOn = true;
  bool isGestureControlOn = false;
  bool showTips = true;

  List<Map<String, dynamic>> selfieFilters = [
    {
      "name": "Beauty",
      "value": "beauty",
      "preview": "https://picsum.photos/100/100?random=1&keyword=beauty",
      "description": "Natural skin smoothing"
    },
    {
      "name": "Glow",
      "value": "glow",
      "preview": "https://picsum.photos/100/100?random=2&keyword=glow",
      "description": "Radiant skin effect"
    },
    {
      "name": "Vintage",
      "value": "vintage",
      "preview": "https://picsum.photos/100/100?random=3&keyword=vintage",
      "description": "Retro portrait style"
    },
    {
      "name": "Pop",
      "value": "pop",
      "preview": "https://picsum.photos/100/100?random=4&keyword=pop",
      "description": "Vibrant colors"
    },
    {
      "name": "B&W",
      "value": "blackwhite",
      "preview": "https://picsum.photos/100/100?random=5&keyword=blackwhite",
      "description": "Classic monochrome"
    },
    {
      "name": "Natural",
      "value": "natural",
      "preview": "https://picsum.photos/100/100?random=6&keyword=natural",
      "description": "No effects"
    }
  ];

  List<Map<String, dynamic>> beautyLevels = [
    {"label": "Off", "value": "off"},
    {"label": "Light", "value": "light"},
    {"label": "Medium", "value": "medium"},
    {"label": "Strong", "value": "strong"},
  ];

  List<String> selfieTips = [
    "Hold your phone at eye level for the best angle",
    "Make sure your face is well-lit and avoid harsh shadows",
    "Smile naturally or try different expressions",
    "Use the timer for hands-free selfies",
    "Try different beauty filters to enhance your look"
  ];

  void takeSelfie() async {
    isCapturing = true;
    setState(() {});

    // Simulate capture process
    await Future.delayed(Duration(milliseconds: 800));

    isCapturing = false;
    setState(() {});

    ss("Selfie captured successfully!");
    //navigateTo('PpaPhotoEditView')
  }

  void startCountdownCapture(int seconds) async {
    showCountdown = true;
    countdown = seconds;
    setState(() {});

    for (int i = seconds; i > 0; i--) {
      countdown = i;
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
    }

    showCountdown = false;
    setState(() {});
    takeSelfie();
  }

  void triggerGestureCapture() {
    ss("Peace sign detected! Taking selfie...");
    startCountdownCapture(3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  // Selfie preview (front camera simulation)
                  Positioned.fill(
                    child: Transform.scale(
                      scaleX: -1, // Mirror effect for front camera
                      child: Image.network(
                        "https://picsum.photos/400/800?random=1&keyword=selfie",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Beauty filter overlay simulation
                  if (selectedFilter != "natural")
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              _getFilterColor().withAlpha(30),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Face detection indicators
                  if (isSmileDetectionOn || isBlinkDetectionOn)
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.15,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: successColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Stack(
                          children: [
                            // Face detection label
                            Positioned(
                              top: -25,
                              left: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Face Detected",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Countdown Overlay
                  if (showCountdown)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withAlpha(150),
                        child: Center(
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "$countdown",
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Capture Flash Effect
                  if (isCapturing)
                    Positioned.fill(
                      child: Container(
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                ],
              ),
            ),

            // Top Controls
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
                      Colors.black.withAlpha(200),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    // Back Button
                    GestureDetector(
                      onTap: () => back(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),

                    SizedBox(width: spSm),

                    // Selfie Mode Info
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.face,
                            color: primaryColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Selfie Mode",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Spacer(),

                    // AI Features Toggle
                    GestureDetector(
                      onTap: () => _showAIFeaturesBottomSheet(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (isSmileDetectionOn || isBlinkDetectionOn || isGestureControlOn)
                              ? primaryColor
                              : Colors.black.withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.psychology,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),

                    SizedBox(width: spSm),

                    // Tips Toggle
                    GestureDetector(
                      onTap: () {
                        showTips = !showTips;
                        setState(() {});
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: showTips ? infoColor : Colors.black.withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lightbulb,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tips Panel
            if (showTips)
              Positioned(
                top: 80,
                left: spMd,
                right: spMd,
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(200),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Selfie Tips",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              showTips = false;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        selfieTips[DateTime.now().millisecond % selfieTips.length],
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Filter Selection (Left Side)
            Positioned(
              left: 0,
              top: MediaQuery.of(context).size.height * 0.3,
              bottom: 200,
              child: Container(
                width: 100,
                child: Column(
                  children: [
                    // Beauty Level
                    Container(
                      margin: EdgeInsets.only(left: spSm, bottom: spMd),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Beauty",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Column(
                            children: beautyLevels.map((level) {
                              final isSelected = selectedBeautyLevel == level["value"];
                              return GestureDetector(
                                onTap: () {
                                  selectedBeautyLevel = level["value"];
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 2),
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryColor : Colors.transparent,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${level["label"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Filters
                    Expanded(
                      child: ListView.builder(
                        itemCount: selfieFilters.length,
                        itemBuilder: (context, index) {
                          final filter = selfieFilters[index];
                          final isSelected = selectedFilter == filter["value"];

                          return GestureDetector(
                            onTap: () {
                              selectedFilter = filter["value"];
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: spSm, bottom: spSm),
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(
                                        color: isSelected ? primaryColor : Colors.white.withAlpha(100),
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      child: Image.network(
                                        "${filter["preview"]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${filter["name"]}",
                                    style: TextStyle(
                                      color: isSelected ? primaryColor : Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
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
            ),

            // Gesture Detection Indicator
            if (isGestureControlOn)
              Positioned(
                right: 20,
                top: MediaQuery.of(context).size.height * 0.4,
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.pan_tool,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Show ✌️\nto capture",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spSm),
                      GestureDetector(
                        onTap: triggerGestureCapture,
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Test",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Bottom Controls
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
                      Colors.black.withAlpha(200),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Timer Options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: takeSelfie,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        GestureDetector(
                          onTap: () => startCountdownCapture(3),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "3s Timer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        GestureDetector(
                          onTap: () => startCountdownCapture(10),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "10s Timer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Main Controls
                    Row(
                      children: [
                        // Gallery Thumbnail
                        GestureDetector(
                          onTap: () {
                            //navigateTo('PpaGalleryView')
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "https://picsum.photos/100/100?random=7&keyword=selfie-thumb",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        Spacer(),

                        // Capture Button
                        GestureDetector(
                          onTap: isCapturing ? null : takeSelfie,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: isCapturing ? disabledColor : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                            child: isCapturing
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  )
                                : Icon(
                                    Icons.face,
                                    color: primaryColor,
                                    size: 32,
                                  ),
                          ),
                        ),

                        Spacer(),

                        // Switch to Back Camera
                        GestureDetector(
                          onTap: () {
                            //navigateTo('PpaCameraView')
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              shape: BoxShape.circle,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getFilterColor() {
    switch (selectedFilter) {
      case "beauty":
        return Colors.pink;
      case "glow":
        return Colors.orange;
      case "vintage":
        return Colors.amber;
      case "pop":
        return Colors.purple;
      case "blackwhite":
        return Colors.grey;
      default:
        return Colors.transparent;
    }
  }

  void _showAIFeaturesBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withAlpha(230),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    children: [
                      Text(
                        "AI Features",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // AI Features Toggles
                  Column(
                    children: [
                      // Smile Detection
                      Row(
                        children: [
                          Icon(
                            Icons.sentiment_satisfied,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Smile Detection",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Auto capture when you smile",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: isSmileDetectionOn,
                            onChanged: (value) {
                              isSmileDetectionOn = value;
                              setState(() {});
                              setModalState(() {});
                            },
                            activeColor: primaryColor,
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Blink Detection
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Blink Detection",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Avoid photos with closed eyes",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: isBlinkDetectionOn,
                            onChanged: (value) {
                              isBlinkDetectionOn = value;
                              setState(() {});
                              setModalState(() {});
                            },
                            activeColor: primaryColor,
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Gesture Control
                      Row(
                        children: [
                          Icon(
                            Icons.pan_tool,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gesture Control",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Capture with peace sign",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: isGestureControlOn,
                            onChanged: (value) {
                              isGestureControlOn = value;
                              setState(() {});
                              setModalState(() {});
                            },
                            activeColor: primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
