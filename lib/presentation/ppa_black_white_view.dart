import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaBlackWhiteView extends StatefulWidget {
  const PpaBlackWhiteView({super.key});

  @override
  State<PpaBlackWhiteView> createState() => _PpaBlackWhiteViewState();
}

class _PpaBlackWhiteViewState extends State<PpaBlackWhiteView> {
  String selectedBWFilter = "";
  double contrastLevel = 0.0;
  double brightnessLevel = 0.0;
  double clarityLevel = 0.0;
  double vignetteLevel = 0.0;
  double grainLevel = 0.0;
  String selectedColorFilter = "None";

  List<Map<String, dynamic>> colorFilters = [
    {"label": "None", "value": "None", "description": "No color filter"},
    {"label": "Red Filter", "value": "Red", "description": "Darkens skies, brightens skin"},
    {"label": "Yellow Filter", "value": "Yellow", "description": "Natural contrast, good for landscapes"},
    {"label": "Orange Filter", "value": "Orange", "description": "Enhanced contrast in portraits"},
    {"label": "Green Filter", "value": "Green", "description": "Lightens foliage, darkens skies"},
    {"label": "Blue Filter", "value": "Blue", "description": "Enhances atmospheric effects"},
  ];

  List<Map<String, dynamic>> blackWhitePresets = [
    {
      "name": "Classic B&W",
      "description": "Traditional black and white",
      "thumbnail": "https://picsum.photos/80/80?random=1&keyword=portrait",
      "contrast": 15.0,
      "brightness": 0.0,
      "clarity": 10.0,
      "vignette": 0.0,
      "grain": 0.0,
      "colorFilter": "None",
    },
    {
      "name": "High Contrast",
      "description": "Dramatic black and white",
      "thumbnail": "https://picsum.photos/80/80?random=2&keyword=architecture",
      "contrast": 40.0,
      "brightness": -5.0,
      "clarity": 25.0,
      "vignette": 20.0,
      "grain": 0.0,
      "colorFilter": "Red",
    },
    {
      "name": "Soft Portrait",
      "description": "Gentle portrait style",
      "thumbnail": "https://picsum.photos/80/80?random=3&keyword=woman",
      "contrast": 8.0,
      "brightness": 5.0,
      "clarity": -5.0,
      "vignette": 15.0,
      "grain": 10.0,
      "colorFilter": "Orange",
    },
    {
      "name": "Landscape",
      "description": "Perfect for outdoor scenes",
      "thumbnail": "https://picsum.photos/80/80?random=4&keyword=landscape",
      "contrast": 25.0,
      "brightness": 0.0,
      "clarity": 20.0,
      "vignette": 10.0,
      "grain": 5.0,
      "colorFilter": "Yellow",
    },
    {
      "name": "Film Noir",
      "description": "Dark dramatic atmosphere",
      "thumbnail": "https://picsum.photos/80/80?random=5&keyword=noir",
      "contrast": 50.0,
      "brightness": -15.0,
      "clarity": 30.0,
      "vignette": 40.0,
      "grain": 20.0,
      "colorFilter": "Red",
    },
    {
      "name": "Street Photography",
      "description": "Urban documentary style",
      "thumbnail": "https://picsum.photos/80/80?random=6&keyword=street",
      "contrast": 20.0,
      "brightness": -5.0,
      "clarity": 15.0,
      "vignette": 5.0,
      "grain": 15.0,
      "colorFilter": "Yellow",
    },
    {
      "name": "Fine Art",
      "description": "Museum quality prints",
      "thumbnail": "https://picsum.photos/80/80?random=7&keyword=art",
      "contrast": 12.0,
      "brightness": 2.0,
      "clarity": 8.0,
      "vignette": 0.0,
      "grain": 0.0,
      "colorFilter": "Green",
    },
    {
      "name": "Vintage",
      "description": "Old-fashioned film look",
      "thumbnail": "https://picsum.photos/80/80?random=8&keyword=vintage",
      "contrast": 18.0,
      "brightness": 3.0,
      "clarity": 5.0,
      "vignette": 25.0,
      "grain": 30.0,
      "colorFilter": "Orange",
    },
  ];

  void _applyBWPreset(Map<String, dynamic> preset) {
    selectedBWFilter = preset["name"];
    contrastLevel = preset["contrast"];
    brightnessLevel = preset["brightness"];
    clarityLevel = preset["clarity"];
    vignetteLevel = preset["vignette"];
    grainLevel = preset["grain"];
    selectedColorFilter = preset["colorFilter"];
    setState(() {});
    ss("Applied ${preset["name"]} B&W preset");
  }

  void _resetBWSettings() {
    selectedBWFilter = "";
    contrastLevel = 0.0;
    brightnessLevel = 0.0;
    clarityLevel = 0.0;
    vignetteLevel = 0.0;
    grainLevel = 0.0;
    selectedColorFilter = "None";
    setState(() {});
    si("Reset to default B&W settings");
  }

  void _autoEnhance() {
    contrastLevel = 20.0;
    clarityLevel = 15.0;
    vignetteLevel = 10.0;
    setState(() {});
    ss("Auto enhancement applied");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Black & White"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: _autoEnhance,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetBWSettings,
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
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/400/250?random=9&keyword=portrait"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.grey,
                    BlendMode.saturation,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 1.2,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha((vignetteLevel * 2.55).toInt()),
                        ],
                      ),
                    ),
                  ),
                  if (selectedBWFilter.isNotEmpty)
                    Positioned(
                      top: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          selectedBWFilter,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  if (selectedColorFilter != "None")
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getColorFilterColor().withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          selectedColorFilter,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Text(
              "Black & White Presets",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: blackWhitePresets.map((preset) {
                bool isSelected = selectedBWFilter == preset["name"];
                return GestureDetector(
                  onTap: () => _applyBWPreset(preset),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                        width: isSelected ? 3 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            image: DecorationImage(
                              image: NetworkImage("${preset["thumbnail"]}"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.grey,
                                BlendMode.saturation,
                              ),
                            ),
                          ),
                          child: Stack(
                            children: [
                              if (isSelected)
                                Positioned(
                                  top: spXs,
                                  right: spXs,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${preset["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${preset["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Contrast: ${(preset["contrast"] as num).toInt()}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            Text(
              "Color Filter Selection",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: colorFilters.map((filter) {
                bool isSelected = selectedColorFilter == filter["value"];
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      selectedColorFilter = filter["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledColor,
                          width: 2,
                        ),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: _getFilterColor(filter["value"]),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: disabledColor),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${filter["label"]}",
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${filter["description"]}",
                            style: TextStyle(
                              color: isSelected ? Colors.white70 : disabledBoldColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "B&W Adjustments",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.contrast, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Contrast: ${contrastLevel.toInt()}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: contrastLevel,
                        min: -50,
                        max: 100,
                        divisions: 150,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          contrastLevel = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.brightness_6, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Brightness: ${brightnessLevel.toInt()}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: brightnessLevel,
                        min: -50,
                        max: 50,
                        divisions: 100,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          brightnessLevel = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.tune, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Clarity: ${clarityLevel.toInt()}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: clarityLevel,
                        min: -50,
                        max: 100,
                        divisions: 150,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          clarityLevel = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.vignette, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Vignette: ${vignetteLevel.toInt()}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: vignetteLevel,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          vignetteLevel = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.grain, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Film Grain: ${grainLevel.toInt()}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: grainLevel,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          grainLevel = value;
                          setState(() {});
                        },
                      ),
                    ],
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
                      Icon(Icons.camera_alt, color: infoColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "B&W Photography Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Use red filters to darken skies dramatically",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Yellow filters provide natural-looking contrast",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Increase clarity for sharp, detailed portraits",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Add grain for authentic film photography feel",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Auto Enhance",
                    size: bs.md,
                    onPressed: _autoEnhance,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply B&W",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        ss("Black & white conversion applied successfully!");
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

  Color _getColorFilterColor() {
    switch (selectedColorFilter) {
      case "Red":
        return Colors.red;
      case "Yellow":
        return Colors.yellow;
      case "Orange":
        return Colors.orange;
      case "Green":
        return Colors.green;
      case "Blue":
        return Colors.blue;
      default:
        return Colors.transparent;
    }
  }

  Color _getFilterColor(String filterValue) {
    switch (filterValue) {
      case "Red":
        return Colors.red;
      case "Yellow":
        return Colors.yellow;
      case "Orange":
        return Colors.orange;
      case "Green":
        return Colors.green;
      case "Blue":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
