import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaBlendModesView extends StatefulWidget {
  const PpaBlendModesView({super.key});

  @override
  State<PpaBlendModesView> createState() => _PpaBlendModesViewState();
}

class _PpaBlendModesViewState extends State<PpaBlendModesView> {
  String selectedBlendMode = "Normal";
  double opacity = 0.8;
  bool showPreview = true;
  String selectedLayer = "Overlay";
  
  List<Map<String, dynamic>> blendModes = [
    {
      "category": "Normal",
      "modes": [
        {"name": "Normal", "value": "Normal", "description": "Default blending mode"},
        {"name": "Dissolve", "value": "Dissolve", "description": "Random pixel pattern"},
      ]
    },
    {
      "category": "Darken",
      "modes": [
        {"name": "Darken", "value": "Darken", "description": "Selects darker pixels"},
        {"name": "Multiply", "value": "Multiply", "description": "Darkens image"},
        {"name": "Color Burn", "value": "ColorBurn", "description": "Increases contrast"},
        {"name": "Linear Burn", "value": "LinearBurn", "description": "Darker linear blend"},
      ]
    },
    {
      "category": "Lighten", 
      "modes": [
        {"name": "Lighten", "value": "Lighten", "description": "Selects lighter pixels"},
        {"name": "Screen", "value": "Screen", "description": "Lightens image"},
        {"name": "Color Dodge", "value": "ColorDodge", "description": "Brightens highlights"},
        {"name": "Linear Dodge", "value": "LinearDodge", "description": "Brighter linear blend"},
      ]
    },
    {
      "category": "Contrast",
      "modes": [
        {"name": "Overlay", "value": "Overlay", "description": "Combines multiply and screen"},
        {"name": "Soft Light", "value": "SoftLight", "description": "Subtle contrast"},
        {"name": "Hard Light", "value": "HardLight", "description": "Strong contrast"},
        {"name": "Vivid Light", "value": "VividLight", "description": "Extreme contrast"},
        {"name": "Linear Light", "value": "LinearLight", "description": "Linear contrast"},
        {"name": "Pin Light", "value": "PinLight", "description": "Replaces pixels"},
      ]
    },
    {
      "category": "Comparative",
      "modes": [
        {"name": "Difference", "value": "Difference", "description": "Subtracts colors"},
        {"name": "Exclusion", "value": "Exclusion", "description": "Similar to difference"},
        {"name": "Subtract", "value": "Subtract", "description": "Subtracts values"},
        {"name": "Divide", "value": "Divide", "description": "Divides values"},
      ]
    },
    {
      "category": "Component",
      "modes": [
        {"name": "Hue", "value": "Hue", "description": "Changes hue only"},
        {"name": "Saturation", "value": "Saturation", "description": "Changes saturation only"},
        {"name": "Color", "value": "Color", "description": "Changes hue and saturation"},
        {"name": "Luminosity", "value": "Luminosity", "description": "Changes brightness only"},
      ]
    },
  ];
  
  List<Map<String, dynamic>> layers = [
    {"label": "Base Layer", "value": "Base"},
    {"label": "Overlay Layer", "value": "Overlay"},
    {"label": "Adjustment Layer", "value": "Adjustment"},
    {"label": "Color Layer", "value": "Color"},
  ];
  
  List<Map<String, dynamic>> presets = [
    {
      "name": "Vintage Look",
      "blendMode": "Multiply",
      "opacity": 0.6,
      "description": "Warm, aged appearance",
    },
    {
      "name": "High Contrast",
      "blendMode": "Overlay",
      "opacity": 0.8,
      "description": "Enhanced contrast and depth",
    },
    {
      "name": "Soft Glow",
      "blendMode": "SoftLight",
      "opacity": 0.4,
      "description": "Gentle lighting effect",
    },
    {
      "name": "Dramatic",
      "blendMode": "HardLight",
      "opacity": 0.7,
      "description": "Bold, dramatic effect",
    },
  ];

  Map<String, dynamic>? get currentBlendMode {
    for (var category in blendModes) {
      for (var mode in category["modes"]) {
        if (mode["value"] == selectedBlendMode) {
          return mode;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blend Modes"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              selectedBlendMode = "Normal";
              opacity = 0.8;
              selectedLayer = "Overlay";
              setState(() {});
              si("Blend settings reset");
            },
          ),
          IconButton(
            icon: Icon(showPreview ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              showPreview = !showPreview;
              setState(() {});
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
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Image.network(
                      "https://picsum.photos/400/300?random=104&keyword=blend",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  if (showPreview)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusMd),
                          color: _getBlendModeColor(),
                        ),
                      ),
                    ),
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.layers,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            selectedBlendMode,
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
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${(opacity * 100).toInt()}%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  if (currentBlendMode != null)
                    Positioned(
                      bottom: spSm,
                      left: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${currentBlendMode!["description"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            Text(
              "Quick Presets",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QHorizontalScroll(
              children: presets.map((preset) {
                final isSelected = selectedBlendMode == preset["blendMode"] && 
                                 (opacity - (preset["opacity"] as double)).abs() < 0.1;
                
                return GestureDetector(
                  onTap: () {
                    selectedBlendMode = preset["blendMode"];
                    opacity = preset["opacity"] as double;
                    setState(() {});
                    ss("Applied ${preset["name"]} preset");
                  },
                  child: Container(
                    width: 140,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${preset["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${preset["blendMode"]} • ${((preset["opacity"] as double) * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${preset["description"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            Text(
              "Blend Mode Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ...blendModes.map((category) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: spSm),
                  Text(
                    "${category["category"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (category["modes"] as List).map<Widget>((mode) {
                      final isSelected = selectedBlendMode == mode["value"];
                      
                      return GestureDetector(
                        onTap: () {
                          selectedBlendMode = mode["value"];
                          setState(() {});
                          si("${mode["name"]} blend mode applied");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Text(
                            "${mode["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : primaryColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            }).toList(),
            
            Text(
              "Blend Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QDropdownField(
              label: "Target Layer",
              items: layers,
              value: selectedLayer,
              onChanged: (value, label) {
                selectedLayer = value;
                setState(() {});
              },
            ),
            
            Text(
              "Opacity: ${(opacity * 100).toInt()}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Slider(
              value: opacity,
              onChanged: (value) {
                opacity = value;
                setState(() {});
              },
              activeColor: primaryColor,
              inactiveColor: disabledColor,
            ),
            
            QSwitch(
              label: "Live Preview",
              items: [
                {
                  "label": "Show blend effect preview",
                  "value": true,
                  "checked": showPreview,
                }
              ],
              value: [
                if (showPreview)
                  {
                    "label": "Show blend effect preview",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showPreview = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset",
                    size: bs.md,
                    onPressed: () {
                      selectedBlendMode = "Normal";
                      opacity = 1.0;
                      setState(() {});
                      si("Blend mode reset");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Blend Mode",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        ss("Blend mode '$selectedBlendMode' applied!");
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
  
  Color _getBlendModeColor() {
    switch (selectedBlendMode) {
      case "Multiply":
        return Colors.black.withAlpha((opacity * 100).toInt());
      case "Screen":
        return Colors.white.withAlpha((opacity * 100).toInt());
      case "Overlay":
        return primaryColor.withAlpha((opacity * 60).toInt());
      case "SoftLight":
        return warningColor.withAlpha((opacity * 40).toInt());
      case "HardLight":
        return dangerColor.withAlpha((opacity * 80).toInt());
      case "ColorBurn":
        return Colors.brown.withAlpha((opacity * 70).toInt());
      case "ColorDodge":
        return successColor.withAlpha((opacity * 50).toInt());
      default:
        return primaryColor.withAlpha((opacity * 50).toInt());
    }
  }
}
