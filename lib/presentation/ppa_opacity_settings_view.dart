import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaOpacitySettingsView extends StatefulWidget {
  const PpaOpacitySettingsView({super.key});

  @override
  State<PpaOpacitySettingsView> createState() => _PpaOpacitySettingsViewState();
}

class _PpaOpacitySettingsViewState extends State<PpaOpacitySettingsView> {
  double globalOpacity = 1.0;
  double layerOpacity = 0.8;
  double maskOpacity = 0.6;
  bool showOpacityMask = true;
  bool linkOpacityLayers = false;
  String selectedLayer = "Layer 1";
  String opacityMode = "Normal";
  
  List<Map<String, dynamic>> layers = [
    {
      "id": "1",
      "name": "Background",
      "opacity": 1.0,
      "visible": true,
      "thumbnail": "https://picsum.photos/60/60?random=30&keyword=background",
    },
    {
      "id": "2",
      "name": "Main Subject",
      "opacity": 0.9,
      "visible": true,
      "thumbnail": "https://picsum.photos/60/60?random=31&keyword=person",
    },
    {
      "id": "3",
      "name": "Overlay Effect",
      "opacity": 0.7,
      "visible": true,
      "thumbnail": "https://picsum.photos/60/60?random=32&keyword=overlay",
    },
    {
      "id": "4",
      "name": "Text Layer",
      "opacity": 0.8,
      "visible": false,
      "thumbnail": "https://picsum.photos/60/60?random=33&keyword=text",
    },
  ];
  
  List<Map<String, dynamic>> opacityModes = [
    {"label": "Normal", "value": "Normal"},
    {"label": "Gradient", "value": "Gradient"},
    {"label": "Radial", "value": "Radial"},
    {"label": "Linear", "value": "Linear"},
    {"label": "Custom Mask", "value": "Custom"},
  ];
  
  List<Map<String, dynamic>> presets = [
    {
      "name": "Subtle",
      "globalOpacity": 0.9,
      "description": "Light transparency effect",
    },
    {
      "name": "Medium",
      "globalOpacity": 0.7,
      "description": "Balanced transparency",
    },
    {
      "name": "Strong",
      "globalOpacity": 0.5,
      "description": "High transparency effect",
    },
    {
      "name": "Dramatic",
      "globalOpacity": 0.3,
      "description": "Very transparent effect",
    },
  ];

  Map<String, dynamic>? get currentLayer {
    return layers.firstWhere(
      (layer) => layer["name"] == selectedLayer,
      orElse: () => layers.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Opacity Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetOpacitySettings();
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              ss("Opacity settings saved");
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
              height: 280,
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
                      "https://picsum.photos/400/280?random=105&keyword=opacity",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        color: Colors.white.withAlpha(((1.0 - globalOpacity) * 255).toInt()),
                      ),
                    ),
                  ),
                  if (showOpacityMask)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusMd),
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 0.8,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha((maskOpacity * 100).toInt()),
                            ],
                          ),
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
                            Icons.opacity,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(globalOpacity * 100).toInt()}%",
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
                    bottom: spSm,
                    left: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Global opacity: ${(globalOpacity * 100).toInt()}% • Mode: $opacityMode",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
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
            
            Text(
              "Opacity Presets",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QHorizontalScroll(
              children: presets.map((preset) {
                final isSelected = (globalOpacity - (preset["globalOpacity"] as double)).abs() < 0.1;
                
                return GestureDetector(
                  onTap: () {
                    globalOpacity = preset["globalOpacity"] as double;
                    setState(() {});
                    ss("Applied ${preset["name"]} opacity preset");
                  },
                  child: Container(
                    width: 120,
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
                          "${((preset["globalOpacity"] as double) * 100).toInt()}%",
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
              "Global Opacity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QDropdownField(
              label: "Opacity Mode",
              items: opacityModes,
              value: opacityMode,
              onChanged: (value, label) {
                opacityMode = value;
                setState(() {});
              },
            ),
            
            Text(
              "Global Opacity: ${(globalOpacity * 100).toInt()}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Slider(
              value: globalOpacity,
              onChanged: (value) {
                globalOpacity = value;
                if (linkOpacityLayers) {
                  _updateAllLayersOpacity(value);
                }
                setState(() {});
              },
              activeColor: primaryColor,
              inactiveColor: disabledColor,
            ),
            
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    label: "Show Opacity Mask",
                    items: [
                      {
                        "label": "Display opacity visualization",
                        "value": true,
                        "checked": showOpacityMask,
                      }
                    ],
                    value: [
                      if (showOpacityMask)
                        {
                          "label": "Display opacity visualization",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showOpacityMask = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    label: "Link Layers",
                    items: [
                      {
                        "label": "Link layer opacity changes",
                        "value": true,
                        "checked": linkOpacityLayers,
                      }
                    ],
                    value: [
                      if (linkOpacityLayers)
                        {
                          "label": "Link layer opacity changes",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      linkOpacityLayers = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            if (showOpacityMask) ...[
              Text(
                "Mask Opacity: ${(maskOpacity * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Slider(
                value: maskOpacity,
                onChanged: (value) {
                  maskOpacity = value;
                  setState(() {});
                },
                activeColor: primaryColor,
                inactiveColor: disabledColor,
              ),
            ],
            
            Text(
              "Layer Opacity Control",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: layers.map((layer) {
                  final isVisible = layer["visible"] as bool;
                  final opacity = layer["opacity"] as double;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusXs),
                          child: Image.network(
                            "${layer["thumbnail"]}",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${layer["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Opacity: ${(opacity * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          width: 100,
                          child: Slider(
                            value: opacity,
                            onChanged: (value) {
                              _updateLayerOpacity(layer["id"], value);
                            },
                            activeColor: primaryColor,
                            inactiveColor: disabledColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () {
                            _toggleLayerVisibility(layer["id"]);
                          },
                          child: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                            color: isVisible ? primaryColor : disabledBoldColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset All",
                    size: bs.md,
                    onPressed: () {
                      _resetOpacitySettings();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Opacity",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        ss("Opacity settings applied successfully!");
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
  
  void _resetOpacitySettings() {
    globalOpacity = 1.0;
    layerOpacity = 0.8;
    maskOpacity = 0.6;
    showOpacityMask = true;
    linkOpacityLayers = false;
    opacityMode = "Normal";
    
    for (int i = 0; i < layers.length; i++) {
      layers[i]["opacity"] = 1.0;
      layers[i]["visible"] = true;
    }
    
    setState(() {});
    si("All opacity settings reset to default");
  }
  
  void _updateLayerOpacity(String layerId, double opacity) {
    final layerIndex = layers.indexWhere((layer) => layer["id"] == layerId);
    if (layerIndex != -1) {
      layers[layerIndex]["opacity"] = opacity;
      setState(() {});
    }
  }
  
  void _toggleLayerVisibility(String layerId) {
    final layerIndex = layers.indexWhere((layer) => layer["id"] == layerId);
    if (layerIndex != -1) {
      layers[layerIndex]["visible"] = !(layers[layerIndex]["visible"] as bool);
      setState(() {});
    }
  }
  
  void _updateAllLayersOpacity(double opacity) {
    for (int i = 0; i < layers.length; i++) {
      layers[i]["opacity"] = opacity;
    }
  }
}
