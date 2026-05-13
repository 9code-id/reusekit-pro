import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaTeethWhiteningView extends StatefulWidget {
  const PpaTeethWhiteningView({super.key});

  @override
  State<PpaTeethWhiteningView> createState() => _PpaTeethWhiteningViewState();
}

class _PpaTeethWhiteningViewState extends State<PpaTeethWhiteningView> {
  String selectedImage = "https://picsum.photos/400/600?random=3&keyword=smile";
  double whiteningIntensity = 0.6;
  double brightness = 0.3;
  double naturalness = 0.8;
  bool autoDetect = true;
  
  List<Map<String, dynamic>> detectedTeeth = [
    {"x": 180.0, "y": 280.0, "width": 120.0, "height": 50.0, "confidence": 0.9},
  ];
  
  List<Map<String, dynamic>> manualAreas = [];
  
  List<Map<String, dynamic>> whiteningLevels = [
    {"label": "Natural", "value": 0.3, "description": "Subtle whitening"},
    {"label": "Moderate", "value": 0.6, "description": "Balanced whitening"},
    {"label": "Strong", "value": 0.8, "description": "Noticeable whitening"},
    {"label": "Maximum", "value": 1.0, "description": "Dramatic whitening"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teeth Whitening"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                manualAreas.clear();
                whiteningIntensity = 0.6;
                brightness = 0.3;
                naturalness = 0.8;
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
                color: Colors.blue.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: Colors.blue.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.brightness_6,
                    color: Colors.blue,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Professional Teeth Whitening",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          "AI-powered teeth detection and natural whitening",
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
                    if (autoDetect)
                      ...detectedTeeth.map((teeth) {
                        return Positioned(
                          left: (teeth["x"] as double) - (teeth["width"] as double) / 2,
                          top: (teeth["y"] as double) - (teeth["height"] as double) / 2,
                          child: Container(
                            width: teeth["width"] as double,
                            height: teeth["height"] as double,
                            decoration: BoxDecoration(
                              color: Colors.blue.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.brightness_6,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ...manualAreas.map((area) {
                      return Positioned(
                        left: (area["x"] as double) - 30,
                        top: (area["y"] as double) - 15,
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: primaryColor,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.brush,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    GestureDetector(
                      onTapDown: (details) {
                        setState(() {
                          manualAreas.add({
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
            
            QSwitch(
              label: "Auto Detection",
              items: [
                {
                  "label": "Enable AI teeth detection",
                  "value": true,
                  "checked": autoDetect,
                }
              ],
              value: [
                if (autoDetect)
                  {
                    "label": "Enable AI teeth detection",
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
              "Whitening Level",
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
                children: whiteningLevels.map((level) {
                  bool isSelected = whiteningIntensity == (level["value"] as double);
                  return GestureDetector(
                    onTap: () {
                      whiteningIntensity = level["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              shape: BoxShape.circle,
                            ),
                            child: isSelected 
                              ? Icon(Icons.check, size: 14, color: Colors.white)
                              : null,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${level["label"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? primaryColor : Colors.black,
                                  ),
                                ),
                                Text(
                                  "${level["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: level["value"],
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
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
              "Fine Adjustments",
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
                        "Brightness",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(brightness * 100).toInt()}%",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: brightness,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    onChanged: (value) {
                      brightness = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Text(
                        "Naturalness",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(naturalness * 100).toInt()}%",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: naturalness,
                    min: 0.3,
                    max: 1.0,
                    divisions: 7,
                    onChanged: (value) {
                      naturalness = value;
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
                        "Professional Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Start with natural or moderate levels for realistic results",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Higher naturalness preserves tooth texture",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Tap to manually select areas if auto-detection misses teeth",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Avoid over-whitening for natural-looking smiles",
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
                        si("Preview updated with whitening effect");
                      });
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Whitening",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 3), () {
                        hideLoading();
                        ss("Teeth whitening applied successfully!");
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
