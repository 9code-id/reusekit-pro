import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaPortraitModeView extends StatefulWidget {
  const PpaPortraitModeView({super.key});

  @override
  State<PpaPortraitModeView> createState() => _PpaPortraitModeViewState();
}

class _PpaPortraitModeViewState extends State<PpaPortraitModeView> {
  double blurIntensity = 3.5;
  String selectedLighting = "Natural";
  bool depthEffectEnabled = true;
  bool aiEnhancementEnabled = true;
  double focalLength = 85;
  String selectedPreset = "Portrait";
  bool isCapturing = false;
  bool showDepthPreview = false;

  List<Map<String, dynamic>> lightingModes = [
    {"label": "Natural", "value": "Natural", "icon": Icons.wb_sunny},
    {"label": "Studio", "value": "Studio", "icon": Icons.lightbulb},
    {"label": "Contour", "value": "Contour", "icon": Icons.contrast},
    {"label": "Stage", "value": "Stage", "icon": Icons.theater_comedy},
    {"label": "Mono", "value": "Mono", "icon": Icons.monochrome_photos},
  ];

  List<Map<String, dynamic>> portraitPresets = [
    {"label": "Portrait", "value": "Portrait", "blur": 3.5},
    {"label": "Headshot", "value": "Headshot", "blur": 5.0},
    {"label": "Beauty", "value": "Beauty", "blur": 2.5},
    {"label": "Fashion", "value": "Fashion", "blur": 4.0},
    {"label": "Classic", "value": "Classic", "blur": 3.0},
  ];

  void _capturePortrait() async {
    setState(() {
      isCapturing = true;
    });

    await Future.delayed(Duration(milliseconds: 800));
    ss("Portrait captured with ${selectedLighting.toLowerCase()} lighting");

    setState(() {
      isCapturing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Preview Background
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              "https://picsum.photos/400/800?random=31&keyword=person",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade800,
                  child: Icon(
                    Icons.camera_alt,
                    size: 100,
                    color: Colors.white.withAlpha(128),
                  ),
                );
              },
            ),
          ),

          // Depth Effect Overlay
          if (depthEffectEnabled && showDepthPreview)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.6,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha((blurIntensity * 25).toInt()),
                  ],
                ),
              ),
            ),

          // Top Controls
          Positioned(
            top: MediaQuery.of(context).padding.top + spSm,
            left: spMd,
            right: spMd,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(128),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(128),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.portrait, color: Colors.white, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Portrait Mode",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(128),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: IconButton(
                    icon: Icon(
                      showDepthPreview ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        showDepthPreview = !showDepthPreview;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Portrait Presets
          Positioned(
            top: MediaQuery.of(context).padding.top + 80,
            left: spMd,
            right: spMd,
            child: Container(
              height: 60,
              child: QHorizontalScroll(
                children: portraitPresets.map((preset) {
                  bool isSelected = selectedPreset == preset["value"];
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPreset = preset["value"];
                          blurIntensity = preset["blur"];
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.black.withAlpha(128),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isSelected ? primaryColor : Colors.white.withAlpha(64),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "${preset["label"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Side Controls Panel
          Positioned(
            right: spSm,
            top: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              width: 60,
              padding: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Depth Effect Toggle
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        depthEffectEnabled = !depthEffectEnabled;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: depthEffectEnabled ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.blur_on,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  // AI Enhancement Toggle
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        aiEnhancementEnabled = !aiEnhancementEnabled;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: aiEnhancementEnabled ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  // Settings
                  GestureDetector(
                    onTap: () {
                      _showPortraitSettings();
                    },
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      child: Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: spMd,
            left: spMd,
            right: spMd,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Lighting Modes
                Container(
                  height: 80,
                  margin: EdgeInsets.only(bottom: spMd),
                  child: QHorizontalScroll(
                    children: lightingModes.map((mode) {
                      bool isSelected = selectedLighting == mode["value"];
                      return Container(
                        margin: EdgeInsets.only(right: spSm),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedLighting = mode["value"];
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor : Colors.black.withAlpha(128),
                                  borderRadius: BorderRadius.circular(radiusMd),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : Colors.white.withAlpha(64),
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  mode["icon"],
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${mode["label"]}",
                                style: TextStyle(
                                  color: isSelected ? primaryColor : Colors.white,
                                  fontSize: 10,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Blur Intensity Slider
                Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(128),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Blur Intensity",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "f/${blurIntensity.toStringAsFixed(1)}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: primaryColor,
                          inactiveTrackColor: Colors.white.withAlpha(64),
                          thumbColor: primaryColor,
                          overlayColor: primaryColor.withAlpha(64),
                        ),
                        child: Slider(
                          value: blurIntensity,
                          min: 1.0,
                          max: 7.0,
                          divisions: 12,
                          onChanged: (value) {
                            setState(() {
                              blurIntensity = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Capture Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Gallery
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(128),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: Colors.white.withAlpha(64)),
                      ),
                      child: Icon(Icons.photo_library, color: Colors.white, size: 24),
                    ),

                    // Capture Button
                    GestureDetector(
                      onTap: _capturePortrait,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 4),
                        ),
                        child: isCapturing
                            ? Container(
                                margin: EdgeInsets.all(spSm),
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                  strokeWidth: 3,
                                ),
                              )
                            : Icon(
                                Icons.camera_alt,
                                color: primaryColor,
                                size: 32,
                              ),
                      ),
                    ),

                    // Switch Camera
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(128),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: Colors.white.withAlpha(64)),
                      ),
                      child: Icon(Icons.flip_camera_ios, color: Colors.white, size: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Focus Indicator (appears when tapping)
          if (isCapturing)
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Icon(
                    Icons.center_focus_strong,
                    color: primaryColor,
                    size: 40,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showPortraitSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(230),
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Portrait Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),

              // Focal Length
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Focal Length",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    "${focalLength.toInt()}mm",
                    style: TextStyle(color: primaryColor, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: primaryColor,
                  inactiveTrackColor: Colors.white.withAlpha(64),
                  thumbColor: primaryColor,
                ),
                child: Slider(
                  value: focalLength,
                  min: 35,
                  max: 135,
                  divisions: 10,
                  onChanged: (value) {
                    setState(() {
                      focalLength = value;
                    });
                  },
                ),
              ),
              SizedBox(height: spSm),

              // Depth Effect
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Depth Effect",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Switch(
                    value: depthEffectEnabled,
                    onChanged: (value) {
                      setState(() {
                        depthEffectEnabled = value;
                      });
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
              SizedBox(height: spSm),

              // AI Enhancement
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "AI Enhancement",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Switch(
                    value: aiEnhancementEnabled,
                    onChanged: (value) {
                      setState(() {
                        aiEnhancementEnabled = value;
                      });
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
              SizedBox(height: spLg),

              // Close Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Done",
                  size: bs.md,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
