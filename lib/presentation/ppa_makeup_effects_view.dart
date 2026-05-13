import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaMakeupEffectsView extends StatefulWidget {
  const PpaMakeupEffectsView({super.key});

  @override
  State<PpaMakeupEffectsView> createState() => _PpaMakeupEffectsViewState();
}

class _PpaMakeupEffectsViewState extends State<PpaMakeupEffectsView> {
  String selectedImage = "https://picsum.photos/400/600?random=7&keyword=portrait";
  
  // Makeup settings
  double foundationOpacity = 0.0;
  double blushIntensity = 0.0;
  double eyeshadowOpacity = 0.0;
  double eyelinerThickness = 0.0;
  double mascaraVolume = 0.0;
  double lipstickOpacity = 0.0;
  double highlighterGlow = 0.0;
  double contouring = 0.0;
  
  String selectedFoundationShade = "Medium";
  String selectedBlushColor = "Pink";
  String selectedEyeshadowColor = "Brown";
  String selectedLipstickColor = "Red";
  
  bool autoDetectFeatures = true;
  bool enableSmoothing = true;
  
  List<Map<String, dynamic>> makeupPresets = [
    {
      "name": "Natural",
      "description": "Everyday look",
      "values": {
        "foundation": 0.3, "blush": 0.2, "eyeshadow": 0.2,
        "eyeliner": 0.1, "mascara": 0.3, "lipstick": 0.2,
        "highlighter": 0.1, "contour": 0.1
      }
    },
    {
      "name": "Glamour",
      "description": "Evening elegance",
      "values": {
        "foundation": 0.5, "blush": 0.4, "eyeshadow": 0.6,
        "eyeliner": 0.5, "mascara": 0.7, "lipstick": 0.6,
        "highlighter": 0.5, "contour": 0.4
      }
    },
    {
      "name": "Dramatic",
      "description": "Bold statement",
      "values": {
        "foundation": 0.6, "blush": 0.5, "eyeshadow": 0.8,
        "eyeliner": 0.8, "mascara": 0.9, "lipstick": 0.8,
        "highlighter": 0.7, "contour": 0.6
      }
    },
  ];
  
  List<Map<String, dynamic>> colorOptions = [
    {"category": "foundation", "colors": ["Light", "Medium", "Dark", "Tan", "Fair"]},
    {"category": "blush", "colors": ["Pink", "Peach", "Rose", "Coral", "Berry"]},
    {"category": "eyeshadow", "colors": ["Brown", "Gold", "Purple", "Blue", "Green", "Gray"]},
    {"category": "lipstick", "colors": ["Red", "Pink", "Nude", "Berry", "Orange", "Coral"]},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Makeup Effects"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetAllMakeup();
              ss("All makeup removed");
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              showLoading();
              Future.delayed(Duration(seconds: 2), () {
                hideLoading();
                ss("Makeup look saved successfully!");
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.pink.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: Colors.pink.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.face_retouching_natural,
                    color: Colors.pink,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Virtual Makeup Studio",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        Text(
                          "Apply professional makeup looks with AI precision",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.network(
                        selectedImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (autoDetectFeatures)
                      Positioned(
                        left: 120,
                        top: 140,
                        child: Container(
                          width: 160,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.pink, width: 2),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Stack(
                            children: [
                              // Face detection overlay
                              Positioned(
                                top: 20,
                                left: 20,
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "FACE DETECTED",
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
                  ],
                ),
              ),
            ),
            
            Text(
              "Makeup Presets",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: makeupPresets.map((preset) {
                  return GestureDetector(
                    onTap: () {
                      _applyMakeupPreset(preset["values"]);
                      si("${preset["name"]} makeup applied");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.pink.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.pink.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.pink.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.face_retouching_natural,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${preset["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${preset["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.auto_awesome,
                            color: Colors.pink,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            Text(
              "Detection Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Column(
              spacing: spSm,
              children: [
                QSwitch(
                  label: "Auto Feature Detection",
                  items: [
                    {
                      "label": "Enable AI facial feature detection",
                      "value": true,
                      "checked": autoDetectFeatures,
                    }
                  ],
                  value: [
                    if (autoDetectFeatures)
                      {
                        "label": "Enable AI facial feature detection",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    autoDetectFeatures = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  label: "Skin Smoothing",
                  items: [
                    {
                      "label": "Apply subtle skin smoothing",
                      "value": true,
                      "checked": enableSmoothing,
                    }
                  ],
                  value: [
                    if (enableSmoothing)
                      {
                        "label": "Apply subtle skin smoothing",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    enableSmoothing = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
            
            Text(
              "Face Makeup",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  _buildMakeupSlider("Foundation", foundationOpacity, Icons.face, (value) {
                    foundationOpacity = value;
                    setState(() {});
                  }),
                  _buildColorSelector("Foundation Shade", selectedFoundationShade, "foundation"),
                  
                  _buildMakeupSlider("Blush", blushIntensity, Icons.face_retouching_natural, (value) {
                    blushIntensity = value;
                    setState(() {});
                  }),
                  _buildColorSelector("Blush Color", selectedBlushColor, "blush"),
                  
                  _buildMakeupSlider("Highlighter", highlighterGlow, Icons.highlight, (value) {
                    highlighterGlow = value;
                    setState(() {});
                  }),
                  
                  _buildMakeupSlider("Contouring", contouring, Icons.face_retouching_off, (value) {
                    contouring = value;
                    setState(() {});
                  }),
                ],
              ),
            ),
            
            Text(
              "Eye Makeup",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  _buildMakeupSlider("Eyeshadow", eyeshadowOpacity, Icons.remove_red_eye, (value) {
                    eyeshadowOpacity = value;
                    setState(() {});
                  }),
                  _buildColorSelector("Eyeshadow Color", selectedEyeshadowColor, "eyeshadow"),
                  
                  _buildMakeupSlider("Eyeliner", eyelinerThickness, Icons.edit, (value) {
                    eyelinerThickness = value;
                    setState(() {});
                  }),
                  
                  _buildMakeupSlider("Mascara", mascaraVolume, Icons.visibility, (value) {
                    mascaraVolume = value;
                    setState(() {});
                  }),
                ],
              ),
            ),
            
            Text(
              "Lip Makeup",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  _buildMakeupSlider("Lipstick", lipstickOpacity, Icons.face_retouching_natural, (value) {
                    lipstickOpacity = value;
                    setState(() {});
                  }),
                  _buildColorSelector("Lipstick Color", selectedLipstickColor, "lipstick"),
                ],
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tips_and_updates,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Makeup Artist Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Start with foundation and build up other features",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Use presets as a base, then customize individual elements",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Natural look works best for everyday photos",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Enable skin smoothing for flawless finish",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Remove All",
                    size: bs.md,
                    onPressed: () {
                      _resetAllMakeup();
                      si("All makeup removed");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Makeup",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 3), () {
                        hideLoading();
                        ss("Makeup look applied successfully!");
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMakeupSlider(String label, double value, IconData icon, Function(double) onChanged) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.pink),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Text(
              "${(value * 100).toInt()}%",
              style: TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: 0.0,
          max: 1.0,
          divisions: 10,
          onChanged: onChanged,
        ),
      ],
    );
  }
  
  Widget _buildColorSelector(String label, String selectedColor, String category) {
    final colors = colorOptions.firstWhere((option) => option["category"] == category)["colors"] as List;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        SizedBox(height: spXs),
        QHorizontalScroll(
          children: colors.map((color) {
            bool isSelected = selectedColor == color;
            return GestureDetector(
              onTap: () {
                _updateSelectedColor(category, color);
              },
              child: Container(
                width: 60,
                margin: EdgeInsets.only(right: spXs),
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.pink.withAlpha(20) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(
                    color: isSelected ? Colors.pink : disabledOutlineBorderColor,
                    width: 2,
                  ),
                ),
                child: Text(
                  color,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.pink : disabledBoldColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
  
  void _updateSelectedColor(String category, String color) {
    setState(() {
      switch (category) {
        case "foundation":
          selectedFoundationShade = color;
          break;
        case "blush":
          selectedBlushColor = color;
          break;
        case "eyeshadow":
          selectedEyeshadowColor = color;
          break;
        case "lipstick":
          selectedLipstickColor = color;
          break;
      }
    });
  }
  
  void _resetAllMakeup() {
    setState(() {
      foundationOpacity = 0.0;
      blushIntensity = 0.0;
      eyeshadowOpacity = 0.0;
      eyelinerThickness = 0.0;
      mascaraVolume = 0.0;
      lipstickOpacity = 0.0;
      highlighterGlow = 0.0;
      contouring = 0.0;
    });
  }
  
  void _applyMakeupPreset(Map<String, dynamic> values) {
    setState(() {
      foundationOpacity = values["foundation"];
      blushIntensity = values["blush"];
      eyeshadowOpacity = values["eyeshadow"];
      eyelinerThickness = values["eyeliner"];
      mascaraVolume = values["mascara"];
      lipstickOpacity = values["lipstick"];
      highlighterGlow = values["highlighter"];
      contouring = values["contour"];
    });
  }
}
