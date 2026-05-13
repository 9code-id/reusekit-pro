import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaSkinSmoothingView extends StatefulWidget {
  const PpaSkinSmoothingView({super.key});

  @override
  State<PpaSkinSmoothingView> createState() => _PpaSkinSmoothingViewState();
}

class _PpaSkinSmoothingViewState extends State<PpaSkinSmoothingView> {
  String selectedImage = "https://picsum.photos/400/600?random=4&keyword=portrait";
  double smoothingIntensity = 0.5;
  double texturePreservation = 0.7;
  double blendRadius = 20.0;
  bool autoDetectSkin = true;
  bool preserveDetails = true;
  
  List<Map<String, dynamic>> faceRegions = [
    {"x": 150.0, "y": 120.0, "width": 120.0, "height": 160.0, "type": "face"},
    {"x": 100.0, "y": 300.0, "width": 80.0, "height": 100.0, "type": "neck"},
  ];
  
  List<Map<String, dynamic>> manualRegions = [];
  
  List<Map<String, dynamic>> smoothingPresets = [
    {"label": "Light", "value": 0.3, "description": "Subtle smoothing", "icon": Icons.filter_1},
    {"label": "Medium", "value": 0.5, "description": "Balanced smoothing", "icon": Icons.filter_2},
    {"label": "Strong", "value": 0.7, "description": "Noticeable smoothing", "icon": Icons.filter_3},
    {"label": "Dramatic", "value": 0.9, "description": "Maximum smoothing", "icon": Icons.filter_4},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skin Smoothing"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                manualRegions.clear();
                smoothingIntensity = 0.5;
                texturePreservation = 0.7;
                blendRadius = 20.0;
              });
              ss("Settings reset to default");
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              showLoading();
              Future.delayed(Duration(seconds: 2), () {
                hideLoading();
                ss("Image saved successfully!");
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
                          "AI Skin Smoothing",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        Text(
                          "Professional skin retouching with texture preservation",
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
                    if (autoDetectSkin)
                      ...faceRegions.map((region) {
                        return Positioned(
                          left: (region["x"] as double) - (region["width"] as double) / 2,
                          top: (region["y"] as double) - (region["height"] as double) / 2,
                          child: Container(
                            width: region["width"] as double,
                            height: region["height"] as double,
                            decoration: BoxDecoration(
                              color: Colors.pink.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: Colors.pink,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${region["type"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ...manualRegions.map((region) {
                      return Positioned(
                        left: (region["x"] as double) - 25,
                        top: (region["y"] as double) - 25,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: primaryColor,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.brush,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      );
                    }).toList(),
                    GestureDetector(
                      onTapDown: (details) {
                        setState(() {
                          manualRegions.add({
                            "x": details.localPosition.dx,
                            "y": details.localPosition.dy,
                          });
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
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
                  label: "Auto Skin Detection",
                  items: [
                    {
                      "label": "Enable AI skin area detection",
                      "value": true,
                      "checked": autoDetectSkin,
                    }
                  ],
                  value: [
                    if (autoDetectSkin)
                      {
                        "label": "Enable AI skin area detection",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    autoDetectSkin = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  label: "Preserve Details",
                  items: [
                    {
                      "label": "Keep eyes, lips and important features sharp",
                      "value": true,
                      "checked": preserveDetails,
                    }
                  ],
                  value: [
                    if (preserveDetails)
                      {
                        "label": "Keep eyes, lips and important features sharp",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    preserveDetails = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
            
            Text(
              "Smoothing Presets",
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
              child: ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: smoothingPresets.map((preset) {
                  bool isSelected = smoothingIntensity == (preset["value"] as double);
                  return GestureDetector(
                    onTap: () {
                      smoothingIntensity = preset["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.pink.withAlpha(20) : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? Colors.pink : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            preset["icon"] as IconData,
                            size: 32,
                            color: isSelected ? Colors.pink : disabledBoldColor,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${preset["label"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.pink : Colors.black,
                            ),
                          ),
                          Text(
                            "${preset["description"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            Text(
              "Advanced Settings",
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
                  Row(
                    children: [
                      Text(
                        "Smoothing Intensity",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(smoothingIntensity * 100).toInt()}%",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: smoothingIntensity,
                    min: 0.1,
                    max: 1.0,
                    divisions: 9,
                    onChanged: (value) {
                      smoothingIntensity = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Text(
                        "Texture Preservation",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(texturePreservation * 100).toInt()}%",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: texturePreservation,
                    min: 0.3,
                    max: 1.0,
                    divisions: 7,
                    onChanged: (value) {
                      texturePreservation = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Text(
                        "Blend Radius",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${blendRadius.toInt()}px",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: blendRadius,
                    min: 5,
                    max: 50,
                    divisions: 45,
                    onChanged: (value) {
                      blendRadius = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tips_and_updates,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Pro Retouching Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Start with light smoothing for natural results",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Higher texture preservation keeps skin realistic",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Larger blend radius creates softer transitions",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Always keep 'Preserve Details' enabled for portraits",
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
                    label: "Preview",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        si("Preview updated with smoothing effect");
                      });
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Smoothing",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 3), () {
                        hideLoading();
                        ss("Skin smoothing applied successfully!");
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
}
