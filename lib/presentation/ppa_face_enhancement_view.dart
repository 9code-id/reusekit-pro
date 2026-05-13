import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaFaceEnhancementView extends StatefulWidget {
  const PpaFaceEnhancementView({super.key});

  @override
  State<PpaFaceEnhancementView> createState() => _PpaFaceEnhancementViewState();
}

class _PpaFaceEnhancementViewState extends State<PpaFaceEnhancementView> {
  String selectedImage = "https://picsum.photos/400/600?random=6&keyword=portrait";
  
  // Enhancement values
  double facialSymmetry = 0.0;
  double eyeEnhancement = 0.0;
  double noseRefinement = 0.0;
  double lipEnhancement = 0.0;
  double jawlineDefinition = 0.0;
  double cheekboneSharpening = 0.0;
  double skinTone = 0.0;
  double overallBrightness = 0.0;
  
  bool autoDetectFeatures = true;
  bool preserveNaturalLook = true;
  
  List<Map<String, dynamic>> faceFeatures = [
    {"type": "left_eye", "x": 140.0, "y": 160.0, "detected": true},
    {"type": "right_eye", "x": 200.0, "y": 158.0, "detected": true},
    {"type": "nose", "x": 170.0, "y": 190.0, "detected": true},
    {"type": "lips", "x": 170.0, "y": 220.0, "detected": true},
    {"type": "jawline", "x": 170.0, "y": 280.0, "detected": true},
  ];
  
  List<Map<String, dynamic>> enhancementPresets = [
    {
      "name": "Natural",
      "description": "Subtle enhancement",
      "values": {
        "facialSymmetry": 0.2,
        "eyeEnhancement": 0.1,
        "noseRefinement": 0.1,
        "lipEnhancement": 0.1,
        "jawlineDefinition": 0.1,
        "cheekboneSharpening": 0.1,
        "skinTone": 0.2,
        "overallBrightness": 0.1,
      }
    },
    {
      "name": "Glamour",
      "description": "Beauty portrait",
      "values": {
        "facialSymmetry": 0.4,
        "eyeEnhancement": 0.6,
        "noseRefinement": 0.3,
        "lipEnhancement": 0.5,
        "jawlineDefinition": 0.4,
        "cheekboneSharpening": 0.5,
        "skinTone": 0.4,
        "overallBrightness": 0.3,
      }
    },
    {
      "name": "Fashion",
      "description": "Editorial style",
      "values": {
        "facialSymmetry": 0.6,
        "eyeEnhancement": 0.8,
        "noseRefinement": 0.5,
        "lipEnhancement": 0.7,
        "jawlineDefinition": 0.7,
        "cheekboneSharpening": 0.8,
        "skinTone": 0.5,
        "overallBrightness": 0.4,
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Face Enhancement"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetAllValues();
              ss("All settings reset to default");
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              showLoading();
              Future.delayed(Duration(seconds: 3), () {
                hideLoading();
                ss("Enhanced image saved successfully!");
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
                color: Colors.purple.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: Colors.purple.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.face_retouching_natural,
                    color: Colors.purple,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AI Face Enhancement",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        Text(
                          "Professional facial feature enhancement with AI precision",
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
                      ...faceFeatures.map((feature) {
                        return Positioned(
                          left: (feature["x"] as double) - 10,
                          top: (feature["y"] as double) - 10,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.purple.withAlpha(200),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Icon(
                                _getFeatureIcon(feature["type"]),
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                  ],
                ),
              ),
            ),
            
            Text(
              "Enhancement Presets",
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
                children: enhancementPresets.map((preset) {
                  return GestureDetector(
                    onTap: () {
                      _applyPreset(preset["values"]);
                      si("${preset["name"]} preset applied");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.purple.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.purple.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.purple.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 20,
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
                                    color: Colors.purple,
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
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            Text(
              "Feature Settings",
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
                  label: "Preserve Natural Look",
                  items: [
                    {
                      "label": "Maintain realistic proportions",
                      "value": true,
                      "checked": preserveNaturalLook,
                    }
                  ],
                  value: [
                    if (preserveNaturalLook)
                      {
                        "label": "Maintain realistic proportions",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    preserveNaturalLook = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
            
            Text(
              "Facial Features",
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
                  _buildSlider("Eye Enhancement", eyeEnhancement, Icons.remove_red_eye, (value) {
                    eyeEnhancement = value;
                    setState(() {});
                  }),
                  
                  _buildSlider("Nose Refinement", noseRefinement, Icons.face, (value) {
                    noseRefinement = value;
                    setState(() {});
                  }),
                  
                  _buildSlider("Lip Enhancement", lipEnhancement, Icons.face_retouching_natural, (value) {
                    lipEnhancement = value;
                    setState(() {});
                  }),
                  
                  _buildSlider("Jawline Definition", jawlineDefinition, Icons.face_retouching_off, (value) {
                    jawlineDefinition = value;
                    setState(() {});
                  }),
                  
                  _buildSlider("Cheekbone Sharpening", cheekboneSharpening, Icons.face_retouching_natural, (value) {
                    cheekboneSharpening = value;
                    setState(() {});
                  }),
                ],
              ),
            ),
            
            Text(
              "Overall Adjustments",
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
                  _buildSlider("Facial Symmetry", facialSymmetry, Icons.balance, (value) {
                    facialSymmetry = value;
                    setState(() {});
                  }),
                  
                  _buildSlider("Skin Tone", skinTone, Icons.palette, (value) {
                    skinTone = value;
                    setState(() {});
                  }),
                  
                  _buildSlider("Overall Brightness", overallBrightness, Icons.brightness_6, (value) {
                    overallBrightness = value;
                    setState(() {});
                  }),
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
                        Icons.warning_amber_outlined,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Enhancement Guidelines",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Use subtle adjustments for natural-looking results",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Keep 'Preserve Natural Look' enabled for realistic proportions",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Start with presets, then fine-tune individual features",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Avoid over-enhancement to maintain authenticity",
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
                        si("Preview updated with enhancements");
                      });
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Enhancement",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 4), () {
                        hideLoading();
                        ss("Face enhancement applied successfully!");
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
  
  Widget _buildSlider(String label, double value, IconData icon, Function(double) onChanged) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: primaryColor),
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
                color: primaryColor,
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
  
  void _resetAllValues() {
    setState(() {
      facialSymmetry = 0.0;
      eyeEnhancement = 0.0;
      noseRefinement = 0.0;
      lipEnhancement = 0.0;
      jawlineDefinition = 0.0;
      cheekboneSharpening = 0.0;
      skinTone = 0.0;
      overallBrightness = 0.0;
    });
  }
  
  void _applyPreset(Map<String, dynamic> values) {
    setState(() {
      facialSymmetry = values["facialSymmetry"];
      eyeEnhancement = values["eyeEnhancement"];
      noseRefinement = values["noseRefinement"];
      lipEnhancement = values["lipEnhancement"];
      jawlineDefinition = values["jawlineDefinition"];
      cheekboneSharpening = values["cheekboneSharpening"];
      skinTone = values["skinTone"];
      overallBrightness = values["overallBrightness"];
    });
  }
  
  IconData _getFeatureIcon(String type) {
    switch (type) {
      case "left_eye":
      case "right_eye": return Icons.remove_red_eye;
      case "nose": return Icons.face;
      case "lips": return Icons.face_retouching_natural;
      case "jawline": return Icons.face_retouching_off;
      default: return Icons.face;
    }
  }
}
