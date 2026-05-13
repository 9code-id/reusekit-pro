import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaHealingBrushView extends StatefulWidget {
  const PpaHealingBrushView({super.key});

  @override
  State<PpaHealingBrushView> createState() => _PpaHealingBrushViewState();
}

class _PpaHealingBrushViewState extends State<PpaHealingBrushView> {
  double brushSize = 25.0;
  double brushOpacity = 1.0;
  double brushHardness = 0.6;
  String healingMode = "spot";
  String blendMode = "normal";
  double sampleRadius = 50.0;
  bool adaptToTexture = true;
  bool adaptToLighting = true;
  bool adaptToColor = true;
  double featherAmount = 0.3;
  bool pressureSensitive = true;
  bool showSampleArea = true;
  List<Map<String, dynamic>> healingHistory = [];

  List<Map<String, dynamic>> healingModes = [
    {
      "label": "Spot Healing",
      "value": "spot",
      "description": "Automatic healing",
      "icon": Icons.healing,
    },
    {
      "label": "Healing Brush",
      "value": "brush",
      "description": "Sample source area",
      "icon": Icons.brush,
    },
    {
      "label": "Patch Tool",
      "value": "patch",
      "description": "Select and replace",
      "icon": Icons.content_copy,
    },
    {
      "label": "Content Aware",
      "value": "content",
      "description": "AI-powered healing",
      "icon": Icons.auto_awesome,
    },
  ];

  List<Map<String, dynamic>> blendModes = [
    {"label": "Normal", "value": "normal"},
    {"label": "Replace", "value": "replace"},
    {"label": "Multiply", "value": "multiply"},
    {"label": "Screen", "value": "screen"},
    {"label": "Overlay", "value": "overlay"},
    {"label": "Soft Light", "value": "softLight"},
    {"label": "Hard Light", "value": "hardLight"},
    {"label": "Lighten", "value": "lighten"},
    {"label": "Darken", "value": "darken"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Healing Brush"),
        actions: [
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: healingHistory.isNotEmpty
                ? () {
                    healingHistory.removeLast();
                    setState(() {});
                    si("Undo last healing");
                  }
                : null,
          ),
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: () {
              ss("Auto-heal applied");
            },
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              ss("Healing brush settings applied");
              // back();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Healing Preview
          Container(
            height: 200,
            width: double.infinity,
            margin: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
              boxShadow: [shadowSm],
            ),
            child: Stack(
              children: [
                // Background image with imperfections
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://picsum.photos/400/200?random=1&keyword=portrait",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Healing brush preview
                Center(
                  child: Container(
                    width: brushSize * 2,
                    height: brushSize * 2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        healingModes.firstWhere(
                          (mode) => mode["value"] == healingMode,
                        )["icon"],
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                
                // Sample area preview
                if (showSampleArea && healingMode != "spot" && healingMode != "content")
                  Positioned(
                    left: 80,
                    top: 60,
                    child: Container(
                      width: sampleRadius,
                      height: sampleRadius,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "SRC",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                
                // Mode indicator
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withAlpha(128),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          healingModes.firstWhere(
                            (mode) => mode["value"] == healingMode,
                          )["icon"],
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          healingModes.firstWhere(
                            (mode) => mode["value"] == healingMode,
                          )["label"],
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
                
                // Fake imperfections to heal
                Positioned(
                  right: 100,
                  top: 80,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.red.withAlpha(128),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "•",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 150,
                  bottom: 40,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.orange.withAlpha(128),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Healing Mode Selection
                  Text(
                    "Healing Mode",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 120,
                    child: QHorizontalScroll(
                      children: healingModes.map((mode) {
                        bool isSelected = healingMode == mode["value"];
                        return GestureDetector(
                          onTap: () {
                            healingMode = mode["value"];
                            setState(() {});
                          },
                          child: Container(
                            width: 120,
                            margin: EdgeInsets.only(right: spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected
                                    ? primaryColor
                                    : disabledOutlineBorderColor,
                              ),
                              boxShadow: [shadowSm],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    mode["icon"],
                                    color: isSelected ? Colors.white : primaryColor,
                                    size: 24,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    mode["label"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    mode["description"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isSelected
                                          ? Colors.white.withAlpha(204)
                                          : disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Brush Size
                  Text(
                    "Brush Size: ${brushSize.toInt()}px",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: brushSize,
                          min: 5,
                          max: 100,
                          divisions: 95,
                          onChanged: (value) {
                            brushSize = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: (brushSize / 4).clamp(5, 40),
                            height: (brushSize / 4).clamp(5, 40),
                            decoration: BoxDecoration(
                              color: Colors.green.withAlpha(128),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Sample Radius (for non-spot modes)
                  if (healingMode != "spot" && healingMode != "content") ...[
                    Text(
                      "Sample Radius: ${sampleRadius.toInt()}px",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Slider(
                      value: sampleRadius,
                      min: 20,
                      max: 150,
                      divisions: 130,
                      onChanged: (value) {
                        sampleRadius = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spMd),
                  ],

                  // Brush Settings
                  Text(
                    "Brush Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),

                  // Opacity
                  Text(
                    "Opacity: ${(brushOpacity * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Slider(
                    value: brushOpacity,
                    min: 0.1,
                    max: 1.0,
                    divisions: 9,
                    onChanged: (value) {
                      brushOpacity = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Hardness
                  Text(
                    "Hardness: ${(brushHardness * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Slider(
                    value: brushHardness,
                    min: 0.0,
                    max: 1.0,
                    divisions: 100,
                    onChanged: (value) {
                      brushHardness = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Feather Amount
                  Text(
                    "Feather: ${(featherAmount * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Slider(
                    value: featherAmount,
                    min: 0.0,
                    max: 1.0,
                    divisions: 100,
                    onChanged: (value) {
                      featherAmount = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),

                  // Blend Mode
                  QDropdownField(
                    label: "Blend Mode",
                    items: blendModes,
                    value: blendMode,
                    onChanged: (value, label) {
                      blendMode = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),

                  // Adaptation Settings
                  Text(
                    "Adaptation Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Adapt to Texture",
                        "value": "texture",
                        "checked": adaptToTexture,
                      },
                      {
                        "label": "Adapt to Lighting",
                        "value": "lighting",
                        "checked": adaptToLighting,
                      },
                      {
                        "label": "Adapt to Color",
                        "value": "color",
                        "checked": adaptToColor,
                      },
                      {
                        "label": "Pressure Sensitivity",
                        "value": "pressure",
                        "checked": pressureSensitive,
                      },
                      {
                        "label": "Show Sample Area",
                        "value": "sample",
                        "checked": showSampleArea,
                      },
                    ],
                    value: [
                      if (adaptToTexture)
                        {
                          "label": "Adapt to Texture",
                          "value": "texture",
                          "checked": true
                        },
                      if (adaptToLighting)
                        {
                          "label": "Adapt to Lighting",
                          "value": "lighting",
                          "checked": true
                        },
                      if (adaptToColor)
                        {
                          "label": "Adapt to Color",
                          "value": "color",
                          "checked": true
                        },
                      if (pressureSensitive)
                        {
                          "label": "Pressure Sensitivity",
                          "value": "pressure",
                          "checked": true
                        },
                      if (showSampleArea)
                        {
                          "label": "Show Sample Area",
                          "value": "sample",
                          "checked": true
                        },
                    ],
                    onChanged: (values, ids) {
                      adaptToTexture = values.any((v) => v["value"] == "texture");
                      adaptToLighting = values.any((v) => v["value"] == "lighting");
                      adaptToColor = values.any((v) => v["value"] == "color");
                      pressureSensitive = values.any((v) => v["value"] == "pressure");
                      showSampleArea = values.any((v) => v["value"] == "sample");
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),

                  // Content-Aware Settings
                  if (healingMode == "content") ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.purple[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.purple[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.auto_awesome,
                                color: Colors.purple[700],
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Content-Aware Healing",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple[700],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "AI-powered healing that intelligently fills based on surrounding content. Best for complex backgrounds and textures.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.purple[600],
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Text("Quality:"),
                              Spacer(),
                              Text("High"),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text("Speed:"),
                              Spacer(),
                              Text("Medium"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                  ],

                  // Healing History
                  if (healingHistory.isNotEmpty) ...[
                    Text(
                      "Healing History (${healingHistory.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.all(spSm),
                        itemCount: healingHistory.length,
                        itemBuilder: (context, index) {
                          final action = healingHistory[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: spXs),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.healing,
                                  size: 16,
                                  color: Colors.green,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Heal ${index + 1}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${action["mode"]})",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    healingHistory.removeAt(index);
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.undo,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: spMd),
                  ],

                  // Quick Actions
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Auto Heal",
                          size: bs.sm,
                          onPressed: () {
                            healingHistory.add({
                              "mode": "auto",
                              "size": brushSize,
                              "timestamp": DateTime.now(),
                            });
                            setState(() {});
                            ss("Auto healing applied");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Reset Settings",
                          size: bs.sm,
                          onPressed: () {
                            brushSize = 25.0;
                            brushOpacity = 1.0;
                            brushHardness = 0.6;
                            healingMode = "spot";
                            blendMode = "normal";
                            sampleRadius = 50.0;
                            adaptToTexture = true;
                            adaptToLighting = true;
                            adaptToColor = true;
                            featherAmount = 0.3;
                            pressureSensitive = true;
                            showSampleArea = true;
                            setState(() {});
                            si("Healing brush settings reset");
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Apply Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Activate Healing Brush",
                      size: bs.md,
                      onPressed: () {
                        healingHistory.add({
                          "mode": healingMode,
                          "size": brushSize,
                          "opacity": brushOpacity,
                          "timestamp": DateTime.now(),
                        });
                        setState(() {});
                        ss("Healing brush activated");
                        // back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
