import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaBlemishRemovalView extends StatefulWidget {
  const PpaBlemishRemovalView({super.key});

  @override
  State<PpaBlemishRemovalView> createState() => _PpaBlemishRemovalViewState();
}

class _PpaBlemishRemovalViewState extends State<PpaBlemishRemovalView> {
  String selectedImage = "https://picsum.photos/400/600?random=5&keyword=portrait";
  double brushSize = 20.0;
  double healingStrength = 0.8;
  double blendMode = 0.6;
  bool autoDetect = true;
  bool showOriginal = false;
  
  List<Map<String, dynamic>> detectedBlemishes = [
    {"x": 180.0, "y": 150.0, "size": 8.0, "type": "acne", "severity": 0.7},
    {"x": 220.0, "y": 200.0, "size": 12.0, "type": "spot", "severity": 0.6},
    {"x": 160.0, "y": 280.0, "size": 6.0, "type": "freckle", "severity": 0.4},
    {"x": 240.0, "y": 170.0, "size": 15.0, "type": "scar", "severity": 0.9},
  ];
  
  List<Map<String, dynamic>> manualBlemishes = [];
  List<Map<String, dynamic>> removedBlemishes = [];
  
  List<Map<String, dynamic>> brushPresets = [
    {"label": "Fine", "size": 10.0, "strength": 0.6, "icon": Icons.circle},
    {"label": "Small", "size": 20.0, "strength": 0.8, "icon": Icons.circle},
    {"label": "Medium", "size": 35.0, "strength": 0.8, "icon": Icons.circle},
    {"label": "Large", "size": 50.0, "strength": 0.7, "icon": Icons.circle},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blemish Removal"),
        actions: [
          IconButton(
            icon: Icon(showOriginal ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              showOriginal = !showOriginal;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () {
              if (removedBlemishes.isNotEmpty) {
                setState(() {
                  removedBlemishes.removeLast();
                });
                si("Last action undone");
              }
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
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.healing,
                    color: successColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AI Blemish Removal",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Smart healing brush for flawless skin retouching",
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
                      child: ColorFiltered(
                        colorFilter: showOriginal 
                          ? ColorFilter.mode(Colors.transparent, BlendMode.multiply)
                          : ColorFilter.mode(Colors.black.withAlpha(0), BlendMode.multiply),
                        child: Image.network(
                          selectedImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (autoDetect && !showOriginal)
                      ...detectedBlemishes.where((blemish) => 
                        !removedBlemishes.any((removed) => 
                          removed["x"] == blemish["x"] && removed["y"] == blemish["y"]
                        )
                      ).map((blemish) {
                        return Positioned(
                          left: (blemish["x"] as double) - (blemish["size"] as double) / 2,
                          top: (blemish["y"] as double) - (blemish["size"] as double) / 2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                removedBlemishes.add(blemish);
                              });
                              ss("Blemish removed");
                            },
                            child: Container(
                              width: blemish["size"] as double,
                              height: blemish["size"] as double,
                              decoration: BoxDecoration(
                                color: _getBlemishColor(blemish["type"]).withAlpha(100),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _getBlemishColor(blemish["type"]),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  _getBlemishIcon(blemish["type"]),
                                  size: (blemish["size"] as double) * 0.4,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    if (!showOriginal)
                      ...manualBlemishes.where((blemish) => 
                        !removedBlemishes.any((removed) => 
                          removed["x"] == blemish["x"] && removed["y"] == blemish["y"]
                        )
                      ).map((blemish) {
                        return Positioned(
                          left: (blemish["x"] as double) - brushSize / 2,
                          top: (blemish["y"] as double) - brushSize / 2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                removedBlemishes.add(blemish);
                              });
                              ss("Manual blemish removed");
                            },
                            child: Container(
                              width: brushSize,
                              height: brushSize,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(100),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.brush,
                                size: brushSize * 0.4,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    GestureDetector(
                      onTapDown: (details) {
                        if (!showOriginal) {
                          setState(() {
                            manualBlemishes.add({
                              "x": details.localPosition.dx,
                              "y": details.localPosition.dy,
                              "type": "manual",
                            });
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.transparent,
                      ),
                    ),
                    if (showOriginal)
                      Positioned(
                        top: spSm,
                        left: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(180),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "ORIGINAL",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            Row(
              children: [
                Text(
                  "Detection Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Found: ${detectedBlemishes.length} blemishes",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            
            QSwitch(
              label: "Auto Detection",
              items: [
                {
                  "label": "Enable AI blemish detection",
                  "value": true,
                  "checked": autoDetect,
                }
              ],
              value: [
                if (autoDetect)
                  {
                    "label": "Enable AI blemish detection",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                autoDetect = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            Text(
              "Brush Presets",
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
                minItemWidth: 100,
                children: brushPresets.map((preset) {
                  bool isSelected = brushSize == (preset["size"] as double);
                  return GestureDetector(
                    onTap: () {
                      brushSize = preset["size"];
                      healingStrength = preset["strength"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? successColor.withAlpha(20) : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? successColor : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? successColor : disabledBoldColor,
                                width: 3,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: (preset["size"] as double) / 3,
                                height: (preset["size"] as double) / 3,
                                decoration: BoxDecoration(
                                  color: isSelected ? successColor : disabledBoldColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${preset["label"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? successColor : Colors.black,
                            ),
                          ),
                          Text(
                            "${(preset["size"] as double).toInt()}px",
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
                        "Brush Size",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${brushSize.toInt()}px",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: brushSize,
                    min: 5,
                    max: 80,
                    divisions: 75,
                    onChanged: (value) {
                      brushSize = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Text(
                        "Healing Strength",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(healingStrength * 100).toInt()}%",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: healingStrength,
                    min: 0.3,
                    max: 1.0,
                    divisions: 7,
                    onChanged: (value) {
                      healingStrength = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Text(
                        "Blend Mode",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(blendMode * 100).toInt()}%",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: blendMode,
                    min: 0.2,
                    max: 1.0,
                    divisions: 8,
                    onChanged: (value) {
                      blendMode = value;
                      setState(() {});
                    },
                  ),
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
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Guide",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Tap detected blemishes to remove them instantly",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Click anywhere to manually mark additional blemishes",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Use the eye icon to compare before/after",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Higher healing strength for better coverage",
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
                    label: "Clear All",
                    size: bs.md,
                    onPressed: () {
                      setState(() {
                        manualBlemishes.clear();
                        removedBlemishes.clear();
                      });
                      si("All selections cleared");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Healing",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 3), () {
                        hideLoading();
                        ss("Blemish removal completed successfully!");
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
  
  Color _getBlemishColor(String type) {
    switch (type) {
      case "acne": return dangerColor;
      case "spot": return warningColor;
      case "freckle": return Colors.orange;
      case "scar": return Colors.purple;
      default: return primaryColor;
    }
  }
  
  IconData _getBlemishIcon(String type) {
    switch (type) {
      case "acne": return Icons.warning;
      case "spot": return Icons.circle;
      case "freckle": return Icons.circle_outlined;
      case "scar": return Icons.linear_scale;
      default: return Icons.healing;
    }
  }
}
