import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaHairColorView extends StatefulWidget {
  const PpaHairColorView({super.key});

  @override
  State<PpaHairColorView> createState() => _PpaHairColorViewState();
}

class _PpaHairColorViewState extends State<PpaHairColorView> {
  String selectedImage = "https://picsum.photos/400/600?random=8&keyword=portrait";
  
  double colorIntensity = 0.7;
  double blendMode = 0.8;
  double naturalness = 0.6;
  bool autoDetectHair = true;
  bool preserveHighlights = true;
  
  String selectedColorCategory = "Natural";
  String selectedSpecificColor = "Brown";
  
  List<Map<String, dynamic>> hairRegions = [
    {"x": 170.0, "y": 80.0, "width": 140.0, "height": 120.0, "confidence": 0.95},
  ];
  
  List<Map<String, dynamic>> manualRegions = [];
  
  List<Map<String, dynamic>> colorCategories = [
    {
      "name": "Natural",
      "colors": [
        {"name": "Black", "hex": "#1B1B1B", "popular": true},
        {"name": "Dark Brown", "hex": "#4A4A4A", "popular": true},
        {"name": "Brown", "hex": "#8B4513", "popular": true},
        {"name": "Light Brown", "hex": "#CD853F", "popular": true},
        {"name": "Blonde", "hex": "#F5DEB3", "popular": true},
        {"name": "Ash Blonde", "hex": "#E6E6E6", "popular": false},
      ]
    },
    {
      "name": "Fashion",
      "colors": [
        {"name": "Platinum", "hex": "#F0F0F0", "popular": true},
        {"name": "Rose Gold", "hex": "#E8B4B8", "popular": true},
        {"name": "Burgundy", "hex": "#800020", "popular": true},
        {"name": "Auburn", "hex": "#A52A2A", "popular": false},
        {"name": "Copper", "hex": "#B87333", "popular": false},
        {"name": "Honey Blonde", "hex": "#FFC649", "popular": false},
      ]
    },
    {
      "name": "Fantasy",
      "colors": [
        {"name": "Electric Blue", "hex": "#0080FF", "popular": true},
        {"name": "Hot Pink", "hex": "#FF1493", "popular": true},
        {"name": "Purple", "hex": "#8A2BE2", "popular": true},
        {"name": "Green", "hex": "#00FF00", "popular": false},
        {"name": "Silver", "hex": "#C0C0C0", "popular": false},
        {"name": "Rainbow", "hex": "#FF6B6B", "popular": false},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hair Color"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                colorIntensity = 0.7;
                blendMode = 0.8;
                naturalness = 0.6;
                selectedColorCategory = "Natural";
                selectedSpecificColor = "Brown";
                manualRegions.clear();
              });
              ss("Hair color settings reset");
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              showLoading();
              Future.delayed(Duration(seconds: 2), () {
                hideLoading();
                ss("Hair color saved successfully!");
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
                color: Colors.orange.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: Colors.orange.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.palette,
                    color: Colors.orange,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AI Hair Color Studio",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          "Transform your hair color with professional AI precision",
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
                    if (autoDetectHair)
                      ...hairRegions.map((region) {
                        return Positioned(
                          left: (region["x"] as double) - (region["width"] as double) / 2,
                          top: (region["y"] as double) - (region["height"] as double) / 2,
                          child: Container(
                            width: region["width"] as double,
                            height: region["height"] as double,
                            decoration: BoxDecoration(
                              color: Colors.orange.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: Colors.orange,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "HAIR ${((region["confidence"] as double) * 100).toInt()}%",
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
                  label: "Auto Hair Detection",
                  items: [
                    {
                      "label": "Enable AI hair area detection",
                      "value": true,
                      "checked": autoDetectHair,
                    }
                  ],
                  value: [
                    if (autoDetectHair)
                      {
                        "label": "Enable AI hair area detection",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    autoDetectHair = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  label: "Preserve Highlights",
                  items: [
                    {
                      "label": "Keep natural hair highlights and texture",
                      "value": true,
                      "checked": preserveHighlights,
                    }
                  ],
                  value: [
                    if (preserveHighlights)
                      {
                        "label": "Keep natural hair highlights and texture",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    preserveHighlights = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
            
            Text(
              "Color Categories",
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
                  QHorizontalScroll(
                    children: colorCategories.map((category) {
                      bool isSelected = selectedColorCategory == category["name"];
                      return GestureDetector(
                        onTap: () {
                          selectedColorCategory = category["name"];
                          selectedSpecificColor = (category["colors"] as List).first["name"];
                          setState(() {});
                        },
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.orange.withAlpha(20) : Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? Colors.orange : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                _getCategoryIcon(category["name"]),
                                size: 24,
                                color: isSelected ? Colors.orange : disabledBoldColor,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${category["name"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? Colors.orange : disabledBoldColor,
                                  fontSize: 12,
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
            
            Text(
              "Hair Colors",
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
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: _getCurrentCategoryColors().map((color) {
                      bool isSelected = selectedSpecificColor == color["name"];
                      bool isPopular = color["popular"];
                      return GestureDetector(
                        onTap: () {
                          selectedSpecificColor = color["name"];
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.orange.withAlpha(20) : Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? Colors.orange : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(int.parse(color["hex"].substring(1), radix: 16) + 0xFF000000),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 3),
                                      boxShadow: [shadowSm],
                                    ),
                                  ),
                                  if (isPopular)
                                    Positioned(
                                      top: -2,
                                      right: -2,
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.star,
                                          size: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${color["name"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? Colors.orange : Colors.black,
                                  fontSize: 12,
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
            
            Text(
              "Color Settings",
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
                      Icon(Icons.opacity, size: 16, color: Colors.orange),
                      SizedBox(width: spXs),
                      Text(
                        "Color Intensity",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(colorIntensity * 100).toInt()}%",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: colorIntensity,
                    min: 0.1,
                    max: 1.0,
                    divisions: 9,
                    onChanged: (value) {
                      colorIntensity = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.gradient, size: 16, color: Colors.orange),
                      SizedBox(width: spXs),
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
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: blendMode,
                    min: 0.3,
                    max: 1.0,
                    divisions: 7,
                    onChanged: (value) {
                      blendMode = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.nature, size: 16, color: Colors.orange),
                      SizedBox(width: spXs),
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
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: naturalness,
                    min: 0.2,
                    max: 1.0,
                    divisions: 8,
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
                        "Hair Coloring Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Natural colors work best with 70-80% intensity",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Fantasy colors may need higher intensity for visibility",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Higher naturalness preserves hair texture",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Tap to manually select missed hair areas",
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
                        si("Hair color preview updated");
                      });
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Color",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 3), () {
                        hideLoading();
                        ss("Hair color applied successfully!");
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
  
  List<Map<String, dynamic>> _getCurrentCategoryColors() {
    return (colorCategories.firstWhere((cat) => cat["name"] == selectedColorCategory)["colors"] as List<Map<String, dynamic>>);
  }
  
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Natural": return Icons.nature;
      case "Fashion": return Icons.style;
      case "Fantasy": return Icons.auto_awesome;
      default: return Icons.palette;
    }
  }
}
