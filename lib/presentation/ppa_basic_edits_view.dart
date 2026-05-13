import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaBasicEditsView extends StatefulWidget {
  const PpaBasicEditsView({super.key});

  @override
  State<PpaBasicEditsView> createState() => _PpaBasicEditsViewState();
}

class _PpaBasicEditsViewState extends State<PpaBasicEditsView> {
  double brightness = 0;
  double contrast = 0;
  double saturation = 0;
  double exposure = 0;
  double highlights = 0;
  double shadows = 0;
  double warmth = 0;
  double tint = 0;
  double vibrance = 0;
  double clarity = 0;
  
  bool hasChanges = false;
  String selectedPreset = "none";
  
  List<Map<String, dynamic>> quickPresets = [
    {
      "id": "none",
      "name": "None",
      "brightness": 0.0,
      "contrast": 0.0,
      "saturation": 0.0,
      "exposure": 0.0,
    },
    {
      "id": "brighten",
      "name": "Brighten",
      "brightness": 25.0,
      "contrast": 10.0,
      "saturation": 5.0,
      "exposure": 15.0,
    },
    {
      "id": "enhance",
      "name": "Enhance",
      "brightness": 10.0,
      "contrast": 20.0,
      "saturation": 15.0,
      "exposure": 5.0,
    },
    {
      "id": "dramatic",
      "name": "Dramatic",
      "brightness": -5.0,
      "contrast": 35.0,
      "saturation": 25.0,
      "exposure": -10.0,
    },
    {
      "id": "soft",
      "name": "Soft",
      "brightness": 15.0,
      "contrast": -10.0,
      "saturation": -5.0,
      "exposure": 10.0,
    },
    {
      "id": "natural",
      "name": "Natural",
      "brightness": 5.0,
      "contrast": 5.0,
      "saturation": -10.0,
      "exposure": 0.0,
    },
  ];

  List<Map<String, dynamic>> adjustmentCategories = [
    {
      "category": "Exposure",
      "tools": [
        {
          "id": "brightness",
          "label": "Brightness",
          "icon": Icons.brightness_6,
          "min": -100.0,
          "max": 100.0,
          "description": "Adjust overall brightness"
        },
        {
          "id": "contrast",
          "label": "Contrast",
          "icon": Icons.contrast,
          "min": -100.0,
          "max": 100.0,
          "description": "Adjust difference between light and dark"
        },
        {
          "id": "exposure",
          "label": "Exposure",
          "icon": Icons.exposure,
          "min": -100.0,
          "max": 100.0,
          "description": "Adjust overall exposure level"
        },
        {
          "id": "highlights",
          "label": "Highlights",
          "icon": Icons.highlight,
          "min": -100.0,
          "max": 100.0,
          "description": "Adjust bright areas"
        },
        {
          "id": "shadows",
          "label": "Shadows",
          "icon": Icons.gradient,
          "min": -100.0,
          "max": 100.0,
          "description": "Adjust dark areas"
        },
      ]
    },
    {
      "category": "Color",
      "tools": [
        {
          "id": "saturation",
          "label": "Saturation",
          "icon": Icons.color_lens,
          "min": -100.0,
          "max": 100.0,
          "description": "Adjust color intensity"
        },
        {
          "id": "vibrance",
          "label": "Vibrance",
          "icon": Icons.palette,
          "min": -100.0,
          "max": 100.0,
          "description": "Smart color enhancement"
        },
        {
          "id": "warmth",
          "label": "Warmth",
          "icon": Icons.wb_sunny,
          "min": -100.0,
          "max": 100.0,
          "description": "Adjust color temperature"
        },
        {
          "id": "tint",
          "label": "Tint",
          "icon": Icons.invert_colors,
          "min": -100.0,
          "max": 100.0,
          "description": "Adjust green/magenta balance"
        },
      ]
    },
    {
      "category": "Detail",
      "tools": [
        {
          "id": "clarity",
          "label": "Clarity",
          "icon": Icons.details,
          "min": -100.0,
          "max": 100.0,
          "description": "Enhance midtone contrast"
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Basic Edits",
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            if (hasChanges) {
              _showDiscardChangesDialog();
            } else {
              back();
            }
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _resetAllChanges();
            },
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _applyChanges();
            },
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Photo Preview
          Container(
            height: 300,
            width: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowLg],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Image.network(
                        "https://picsum.photos/600/400?random=1&keyword=landscape",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
                
                // Changes Indicator
                if (hasChanges)
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "EDITED",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                // Before/After Toggle
                Positioned(
                  top: spMd,
                  left: spMd,
                  child: GestureDetector(
                    onTap: () {
                      // Toggle before/after view
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "COMPARE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Quick Presets
          Container(
            height: 80,
            color: Colors.grey[900],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Text(
                    "Quick Presets",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: QHorizontalScroll(
                    children: quickPresets.map((preset) {
                      final isSelected = selectedPreset == preset["id"];
                      return GestureDetector(
                        onTap: () {
                          _applyPreset(preset);
                        },
                        child: Container(
                          width: 80,
                          margin: EdgeInsets.only(
                            left: spSm,
                            right: spXs,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor : Colors.grey[700],
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${preset["name"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
              ],
            ),
          ),
          
          // Adjustment Controls
          Expanded(
            child: Container(
              color: Colors.grey[850],
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: adjustmentCategories.map((category) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: spSm),
                          child: Text(
                            "${category["category"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        
                        Column(
                          spacing: spSm,
                          children: (category["tools"] as List).map((tool) {
                            double currentValue = _getAdjustmentValue(tool["id"]);
                            bool hasValue = currentValue != 0;
                            
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: hasValue ? primaryColor.withAlpha(20) : Colors.grey[800],
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: hasValue ? primaryColor.withAlpha(100) : Colors.transparent,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        tool["icon"],
                                        color: hasValue ? primaryColor : Colors.grey[400],
                                        size: 18,
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${tool["label"]}",
                                              style: TextStyle(
                                                color: hasValue ? primaryColor : Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "${tool["description"]}",
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: hasValue ? primaryColor : Colors.grey[700],
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${currentValue.round()}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      if (hasValue) ...[
                                        SizedBox(width: spXs),
                                        GestureDetector(
                                          onTap: () {
                                            _setAdjustmentValue(tool["id"], 0);
                                            _checkForChanges();
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.refresh,
                                            color: primaryColor,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: primaryColor,
                                      inactiveTrackColor: Colors.grey[600],
                                      thumbColor: primaryColor,
                                      overlayColor: primaryColor.withAlpha(50),
                                      trackHeight: 3,
                                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                                    ),
                                    child: Slider(
                                      value: currentValue,
                                      min: tool["min"],
                                      max: tool["max"],
                                      onChanged: (value) {
                                        _setAdjustmentValue(tool["id"], value);
                                        _checkForChanges();
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${tool["min"].round()}",
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        "0",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${tool["max"].round()}",
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList().cast<Widget>(),
                        ),
                        
                        SizedBox(height: spMd),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          
          // Bottom Action Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[900],
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset All",
                    icon: Icons.refresh,
                    size: bs.sm,
                    onPressed: hasChanges ? () {
                      _resetAllChanges();
                    } : null,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: hasChanges ? "Apply Changes" : "No Changes",
                    icon: hasChanges ? Icons.check : Icons.info,
                    size: bs.sm,
                    onPressed: hasChanges ? () {
                      _applyChanges();
                    } : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _getAdjustmentValue(String toolId) {
    switch (toolId) {
      case "brightness": return brightness;
      case "contrast": return contrast;
      case "saturation": return saturation;
      case "exposure": return exposure;
      case "highlights": return highlights;
      case "shadows": return shadows;
      case "warmth": return warmth;
      case "tint": return tint;
      case "vibrance": return vibrance;
      case "clarity": return clarity;
      default: return 0;
    }
  }

  void _setAdjustmentValue(String toolId, double value) {
    switch (toolId) {
      case "brightness": brightness = value; break;
      case "contrast": contrast = value; break;
      case "saturation": saturation = value; break;
      case "exposure": exposure = value; break;
      case "highlights": highlights = value; break;
      case "shadows": shadows = value; break;
      case "warmth": warmth = value; break;
      case "tint": tint = value; break;
      case "vibrance": vibrance = value; break;
      case "clarity": clarity = value; break;
    }
  }

  void _checkForChanges() {
    hasChanges = brightness != 0 ||
        contrast != 0 ||
        saturation != 0 ||
        exposure != 0 ||
        highlights != 0 ||
        shadows != 0 ||
        warmth != 0 ||
        tint != 0 ||
        vibrance != 0 ||
        clarity != 0;
  }

  void _applyPreset(Map<String, dynamic> preset) {
    selectedPreset = preset["id"];
    
    if (preset["id"] == "none") {
      _resetAllChanges();
    } else {
      brightness = preset["brightness"] ?? 0;
      contrast = preset["contrast"] ?? 0;
      saturation = preset["saturation"] ?? 0;
      exposure = preset["exposure"] ?? 0;
      highlights = 0;
      shadows = 0;
      warmth = 0;
      tint = 0;
      vibrance = 0;
      clarity = 0;
      
      _checkForChanges();
    }
    
    setState(() {});
  }

  void _resetAllChanges() {
    brightness = 0;
    contrast = 0;
    saturation = 0;
    exposure = 0;
    highlights = 0;
    shadows = 0;
    warmth = 0;
    tint = 0;
    vibrance = 0;
    clarity = 0;
    selectedPreset = "none";
    hasChanges = false;
    setState(() {});
  }

  void _showDiscardChangesDialog() async {
    bool isConfirmed = await confirm("Discard all changes?");
    if (isConfirmed) {
      back();
    }
  }

  void _applyChanges() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Basic edits applied successfully!");
      back();
    });
  }
}
