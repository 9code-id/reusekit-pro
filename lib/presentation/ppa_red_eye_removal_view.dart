import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaRedEyeRemovalView extends StatefulWidget {
  const PpaRedEyeRemovalView({super.key});

  @override
  State<PpaRedEyeRemovalView> createState() => _PpaRedEyeRemovalViewState();
}

class _PpaRedEyeRemovalViewState extends State<PpaRedEyeRemovalView> {
  String selectedImage = "https://picsum.photos/400/600?random=2&keyword=face";
  double eyeSize = 25.0;
  double intensity = 0.9;
  bool autoDetect = true;
  String eyeColor = "Natural";
  
  List<Map<String, dynamic>> detectedEyes = [
    {"x": 150.0, "y": 180.0, "side": "left", "severity": 0.8},
    {"x": 200.0, "y": 175.0, "side": "right", "severity": 0.9},
  ];
  
  List<Map<String, dynamic>> manualEyes = [];
  
  List<Map<String, dynamic>> eyeColorOptions = [
    {"label": "Natural Brown", "value": "Natural", "color": Colors.brown},
    {"label": "Dark Brown", "value": "DarkBrown", "color": Colors.brown[800]},
    {"label": "Hazel", "value": "Hazel", "color": Colors.amber[700]},
    {"label": "Green", "value": "Green", "color": Colors.green[600]},
    {"label": "Blue", "value": "Blue", "color": Colors.blue[600]},
    {"label": "Grey", "value": "Grey", "color": Colors.grey[600]},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Red Eye Removal"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                manualEyes.clear();
              });
              ss("Manual selections cleared");
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
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    color: dangerColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Red Eye Correction",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Automatically detect and fix red eyes in photos",
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
                      ...detectedEyes.map((eye) {
                        return Positioned(
                          left: (eye["x"] as double) - eyeSize / 2,
                          top: (eye["y"] as double) - eyeSize / 2,
                          child: Container(
                            width: eyeSize,
                            height: eyeSize,
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(100),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: dangerColor,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                eye["side"] == "left" ? Icons.visibility : Icons.visibility_off,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ...manualEyes.map((eye) {
                      return Positioned(
                        left: (eye["x"] as double) - eyeSize / 2,
                        top: (eye["y"] as double) - eyeSize / 2,
                        child: Container(
                          width: eyeSize,
                          height: eyeSize,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(100),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryColor,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.remove_red_eye,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    GestureDetector(
                      onTapDown: (details) {
                        setState(() {
                          manualEyes.add({
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
                  "label": "Enable AI red eye detection",
                  "value": true,
                  "checked": autoDetect,
                }
              ],
              value: [
                if (autoDetect)
                  {
                    "label": "Enable AI red eye detection",
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
              "Correction Settings",
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
                        "Eye Size",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${eyeSize.toInt()}px",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: eyeSize,
                    min: 10,
                    max: 60,
                    divisions: 50,
                    onChanged: (value) {
                      eyeSize = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Text(
                        "Correction Intensity",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(intensity * 100).toInt()}%",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: intensity,
                    min: 0.3,
                    max: 1.0,
                    divisions: 7,
                    onChanged: (value) {
                      intensity = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            Text(
              "Eye Color Replacement",
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
                  Text(
                    "Select Natural Eye Color",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  QHorizontalScroll(
                    children: eyeColorOptions.map((option) {
                      bool isSelected = eyeColor == option["value"];
                      return GestureDetector(
                        onTap: () {
                          eyeColor = option["value"];
                          setState(() {});
                        },
                        child: Container(
                          width: 80,
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: option["color"] as Color,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${option["label"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "How It Works",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• AI automatically detects red eyes in the photo",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Tap on additional eyes to manually mark them",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Choose natural eye color for replacement",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Adjust intensity for natural-looking results",
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
                        si("Preview updated with corrections");
                      });
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Correction",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 3), () {
                        hideLoading();
                        ss("Red eye correction applied successfully!");
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
