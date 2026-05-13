import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaSpotRemovalView extends StatefulWidget {
  const PpaSpotRemovalView({super.key});

  @override
  State<PpaSpotRemovalView> createState() => _PpaSpotRemovalViewState();
}

class _PpaSpotRemovalViewState extends State<PpaSpotRemovalView> {
  String selectedImage = "https://picsum.photos/400/600?random=1&keyword=portrait";
  double spotSize = 15.0;
  double opacity = 0.8;
  bool autoDetect = true;
  
  List<Map<String, dynamic>> detectedSpots = [
    {"x": 120.0, "y": 180.0, "confidence": 0.9},
    {"x": 250.0, "y": 220.0, "confidence": 0.8},
    {"x": 180.0, "y": 350.0, "confidence": 0.7},
    {"x": 300.0, "y": 280.0, "confidence": 0.85},
  ];
  
  List<Map<String, dynamic>> manualSpots = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spot Removal"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                manualSpots.clear();
              });
              ss("Spots cleared");
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
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_fix_high,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Smart Spot Removal",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "AI-powered spot detection and removal tool",
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
                      ...detectedSpots.map((spot) {
                        return Positioned(
                          left: (spot["x"] as double) - spotSize / 2,
                          top: (spot["y"] as double) - spotSize / 2,
                          child: Container(
                            width: spotSize,
                            height: spotSize,
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(100),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: dangerColor,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "${((spot["confidence"] as double) * 100).toInt()}%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ...manualSpots.map((spot) {
                      return Positioned(
                        left: (spot["x"] as double) - spotSize / 2,
                        top: (spot["y"] as double) - spotSize / 2,
                        child: Container(
                          width: spotSize,
                          height: spotSize,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(100),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryColor,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    GestureDetector(
                      onTapDown: (details) {
                        setState(() {
                          manualSpots.add({
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
                  "label": "Enable AI spot detection",
                  "value": true,
                  "checked": autoDetect,
                }
              ],
              value: [
                if (autoDetect)
                  {
                    "label": "Enable AI spot detection",
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
              "Brush Settings",
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
                        "Spot Size",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${spotSize.toInt()}px",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: spotSize,
                    min: 5,
                    max: 50,
                    divisions: 45,
                    onChanged: (value) {
                      spotSize = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Text(
                        "Opacity",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(opacity * 100).toInt()}%",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: opacity,
                    min: 0.1,
                    max: 1.0,
                    divisions: 9,
                    onChanged: (value) {
                      opacity = value;
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
                        Icons.lightbulb_outline,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Pro Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Tap anywhere on the image to add manual spots",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Use smaller brush size for precise editing",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• AI detection shows confidence percentage",
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
                    label: "Reset All",
                    size: bs.md,
                    onPressed: () {
                      setState(() {
                        manualSpots.clear();
                        spotSize = 15.0;
                        opacity = 0.8;
                        autoDetect = true;
                      });
                      si("Settings reset to default");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Removal",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 3), () {
                        hideLoading();
                        ss("Spot removal applied successfully!");
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
