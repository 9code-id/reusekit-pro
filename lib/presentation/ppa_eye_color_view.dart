import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaEyeColorView extends StatefulWidget {
  const PpaEyeColorView({super.key});

  @override
  State<PpaEyeColorView> createState() => _PpaEyeColorViewState();
}

class _PpaEyeColorViewState extends State<PpaEyeColorView> {
  Color selectedEyeColor = Colors.blue;
  double intensity = 75.0;
  double blendAmount = 50.0;
  double saturation = 100.0;
  bool preserveHighlights = true;
  bool autoDetectEyes = true;
  List<Offset> eyePositions = [];

  List<Color> eyeColors = [
    Colors.blue,
    Colors.green,
    Colors.brown,
    Colors.grey,
    Colors.amber,
    Color(0xFF4A90E2), // Light Blue
    Color(0xFF7ED321), // Light Green
    Color(0xFF8B4513), // Saddle Brown
    Color(0xFF6A0DAD), // Purple
    Color(0xFFFFD700), // Gold
    Color(0xFF32CD32), // Lime Green
    Color(0xFF000080), // Navy Blue
  ];

  List<Map<String, dynamic>> presets = [
    {"name": "Natural Blue", "color": Colors.blue, "intensity": 60.0},
    {"name": "Emerald Green", "color": Colors.green, "intensity": 70.0},
    {"name": "Hazel Brown", "color": Colors.brown, "intensity": 55.0},
    {"name": "Steel Grey", "color": Colors.grey, "intensity": 65.0},
    {"name": "Amber Gold", "color": Colors.amber, "intensity": 80.0},
    {"name": "Violet", "color": Color(0xFF6A0DAD), "intensity": 75.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eye Color"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: () {
              _autoDetectEyes();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetSettings();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Image Preview
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: Stack(
                  children: [
                    // Portrait Image
                    GestureDetector(
                      onTapDown: (details) {
                        if (!autoDetectEyes) {
                          // Manual eye position selection
                          eyePositions.add(details.localPosition);
                          if (eyePositions.length > 2) {
                            eyePositions.removeAt(0);
                          }
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.network(
                          "https://picsum.photos/400/300?random=6&keyword=face,portrait",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Eye Position Markers
                    ...eyePositions.asMap().entries.map((entry) {
                      int index = entry.key;
                      Offset position = entry.value;
                      return Positioned(
                        left: position.dx - 15,
                        top: position.dy - 15,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: selectedEyeColor, width: 2),
                            borderRadius: BorderRadius.circular(15),
                            color: selectedEyeColor.withAlpha(100),
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),

                    // Auto Detection Indicator
                    if (autoDetectEyes)
                      Positioned(
                        top: spSm,
                        left: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(200),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.visibility,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Auto Detect ON",
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

                    // Color Preview
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedEyeColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [shadowMd],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Color Selection
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Eye Colors",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                QHorizontalScroll(
                  children: eyeColors.map((color) {
                    bool isSelected = selectedEyeColor == color;
                    return GestureDetector(
                      onTap: () {
                        selectedEyeColor = color;
                        setState(() {});
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: isSelected ? primaryColor : Colors.white,
                            width: isSelected ? 3 : 2,
                          ),
                          boxShadow: isSelected ? [shadowMd] : [shadowSm],
                        ),
                        child: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 24,
                            )
                          : null,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Controls Panel
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusLg),
                  topRight: Radius.circular(radiusLg),
                ),
                boxShadow: [shadowLg],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Eye Color Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),

                    // Intensity
                    _buildSliderControl(
                      label: "Intensity",
                      value: intensity,
                      min: 0,
                      max: 100,
                      suffix: "%",
                      onChanged: (value) {
                        intensity = value;
                        setState(() {});
                      },
                    ),

                    SizedBox(height: spMd),

                    // Blend Amount
                    _buildSliderControl(
                      label: "Blend Amount",
                      value: blendAmount,
                      min: 0,
                      max: 100,
                      suffix: "%",
                      onChanged: (value) {
                        blendAmount = value;
                        setState(() {});
                      },
                    ),

                    SizedBox(height: spMd),

                    // Saturation
                    _buildSliderControl(
                      label: "Saturation",
                      value: saturation,
                      min: 0,
                      max: 200,
                      suffix: "%",
                      onChanged: (value) {
                        saturation = value;
                        setState(() {});
                      },
                    ),

                    SizedBox(height: spMd),

                    // Settings Toggles
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Auto Detect Eyes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Switch(
                          value: autoDetectEyes,
                          onChanged: (value) {
                            autoDetectEyes = value;
                            if (!value) {
                              eyePositions.clear();
                            }
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Preserve Highlights",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Switch(
                          value: preserveHighlights,
                          onChanged: (value) {
                            preserveHighlights = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),

                    if (!autoDetectEyes) ...[
                      SizedBox(height: spMd),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: infoColor.withAlpha(100)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Tap on the image to manually mark eye positions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    SizedBox(height: spLg),

                    // Presets
                    Text(
                      "Quick Presets",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),

                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 120,
                      children: presets.map((preset) {
                        return GestureDetector(
                          onTap: () {
                            selectedEyeColor = preset["color"];
                            intensity = preset["intensity"];
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (preset["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(color: (preset["color"] as Color).withAlpha(100)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: preset["color"],
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [shadowSm],
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  preset["name"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: preset["color"],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: spLg),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Clear Positions",
                            color: warningColor,
                            size: bs.md,
                            onPressed: () {
                              eyePositions.clear();
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Apply Color",
                            size: bs.md,
                            onPressed: () {
                              if (autoDetectEyes || eyePositions.isNotEmpty) {
                                ss("Eye color applied successfully");
                              } else {
                                se("Please mark eye positions first");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderControl({
    required String label,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
    String suffix = "",
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Text(
              "${value.toInt()}$suffix",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: selectedEyeColor,
            inactiveTrackColor: disabledColor,
            thumbColor: selectedEyeColor,
            overlayColor: selectedEyeColor.withAlpha(30),
            trackHeight: 4,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _autoDetectEyes() {
    // Simulate auto detection
    eyePositions = [
      Offset(120, 120), // Left eye
      Offset(180, 120), // Right eye
    ];
    setState(() {});
    ss("Eyes detected automatically");
  }

  void _resetSettings() {
    selectedEyeColor = Colors.blue;
    intensity = 75.0;
    blendAmount = 50.0;
    saturation = 100.0;
    preserveHighlights = true;
    autoDetectEyes = true;
    eyePositions.clear();
    setState(() {});
  }
}
