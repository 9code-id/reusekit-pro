import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaSepiaView extends StatefulWidget {
  const PpaSepiaView({super.key});

  @override
  State<PpaSepiaView> createState() => _PpaSepiaViewState();
}

class _PpaSepiaViewState extends State<PpaSepiaView> {
  double sepiaIntensity = 70.0;
  double warmthLevel = 50.0;
  double contrastLevel = 15.0;
  double vignetteLevel = 20.0;
  double grainLevel = 25.0;
  double fadeLevel = 30.0;
  String selectedSepiaStyle = "";

  List<Map<String, dynamic>> sepiaStyles = [
    {
      "name": "Classic Sepia",
      "description": "Traditional warm brown tones",
      "thumbnail": "https://picsum.photos/80/80?random=1&keyword=vintage",
      "intensity": 70.0,
      "warmth": 50.0,
      "contrast": 15.0,
      "vignette": 20.0,
      "grain": 25.0,
      "fade": 30.0,
      "color": Colors.brown,
    },
    {
      "name": "Deep Sepia",
      "description": "Rich, dark brown tones",
      "thumbnail": "https://picsum.photos/80/80?random=2&keyword=portrait",
      "intensity": 85.0,
      "warmth": 70.0,
      "contrast": 25.0,
      "vignette": 35.0,
      "grain": 20.0,
      "fade": 15.0,
      "color": Colors.brown[800]!,
    },
    {
      "name": "Light Sepia",
      "description": "Subtle vintage warmth",
      "thumbnail": "https://picsum.photos/80/80?random=3&keyword=nature",
      "intensity": 45.0,
      "warmth": 35.0,
      "contrast": 8.0,
      "vignette": 10.0,
      "grain": 15.0,
      "fade": 40.0,
      "color": Colors.amber[200]!,
    },
    {
      "name": "Golden Sepia",
      "description": "Bright golden vintage effect",
      "thumbnail": "https://picsum.photos/80/80?random=4&keyword=sunset",
      "intensity": 60.0,
      "warmth": 80.0,
      "contrast": 20.0,
      "vignette": 15.0,
      "grain": 10.0,
      "fade": 25.0,
      "color": Colors.orange[300]!,
    },
    {
      "name": "Cool Sepia",
      "description": "Blue-tinted vintage look",
      "thumbnail": "https://picsum.photos/80/80?random=5&keyword=city",
      "intensity": 55.0,
      "warmth": 25.0,
      "contrast": 18.0,
      "vignette": 25.0,
      "grain": 30.0,
      "fade": 35.0,
      "color": Colors.blueGrey[300]!,
    },
    {
      "name": "Antique Sepia",
      "description": "Old photograph aesthetic",
      "thumbnail": "https://picsum.photos/80/80?random=6&keyword=old",
      "intensity": 75.0,
      "warmth": 60.0,
      "contrast": 30.0,
      "vignette": 45.0,
      "grain": 40.0,
      "fade": 20.0,
      "color": Colors.brown[600]!,
    },
    {
      "name": "Faded Sepia",
      "description": "Heavily faded vintage",
      "thumbnail": "https://picsum.photos/80/80?random=7&keyword=memory",
      "intensity": 50.0,
      "warmth": 40.0,
      "contrast": 5.0,
      "vignette": 30.0,
      "grain": 35.0,
      "fade": 60.0,
      "color": Colors.brown[300]!,
    },
    {
      "name": "Rich Sepia",
      "description": "Saturated warm tones",
      "thumbnail": "https://picsum.photos/80/80?random=8&keyword=family",
      "intensity": 90.0,
      "warmth": 75.0,
      "contrast": 35.0,
      "vignette": 20.0,
      "grain": 15.0,
      "fade": 10.0,
      "color": Colors.orange[800]!,
    },
  ];

  void _applySepiaStyle(Map<String, dynamic> style) {
    selectedSepiaStyle = style["name"];
    sepiaIntensity = style["intensity"];
    warmthLevel = style["warmth"];
    contrastLevel = style["contrast"];
    vignetteLevel = style["vignette"];
    grainLevel = style["grain"];
    fadeLevel = style["fade"];
    setState(() {});
    ss("Applied ${style["name"]} style");
  }

  void _resetSepiaSettings() {
    selectedSepiaStyle = "";
    sepiaIntensity = 70.0;
    warmthLevel = 50.0;
    contrastLevel = 15.0;
    vignetteLevel = 20.0;
    grainLevel = 25.0;
    fadeLevel = 30.0;
    setState(() {});
    si("Reset to default sepia settings");
  }

  void _autoSepiaAdjust() {
    sepiaIntensity = 65.0;
    warmthLevel = 55.0;
    contrastLevel = 20.0;
    vignetteLevel = 25.0;
    setState(() {});
    ss("Auto sepia adjustment applied");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sepia"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: _autoSepiaAdjust,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetSepiaSettings,
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
                  image: NetworkImage("https://picsum.photos/400/250?random=9&keyword=family"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      gradient: LinearGradient(
                        colors: [
                          _getSepiaColor().withAlpha((sepiaIntensity * 1.5).toInt()),
                          Colors.transparent,
                          _getSepiaColor().withAlpha((sepiaIntensity * 1.2).toInt()),
                        ],
                      ),
                    ),
                  ),
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
                  if (selectedSepiaStyle.isNotEmpty)
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
                          selectedSepiaStyle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getSepiaColor().withAlpha(200),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Sepia ${sepiaIntensity.toInt()}%",
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
              "Sepia Styles",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: sepiaStyles.map((style) {
                bool isSelected = selectedSepiaStyle == style["name"];
                return GestureDetector(
                  onTap: () => _applySepiaStyle(style),
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
                              image: NetworkImage("${style["thumbnail"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                              gradient: LinearGradient(
                                colors: [
                                  (style["color"] as Color).withAlpha(120),
                                  Colors.transparent,
                                  (style["color"] as Color).withAlpha(80),
                                ],
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
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${style["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${style["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: style["color"] as Color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Intensity: ${(style["intensity"] as num).toInt()}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
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
                    "Sepia Adjustments",
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
                          Icon(Icons.palette, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Sepia Intensity: ${sepiaIntensity.toInt()}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: sepiaIntensity,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        activeColor: Colors.brown,
                        onChanged: (value) {
                          sepiaIntensity = value;
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
                          Icon(Icons.wb_sunny, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Warmth: ${warmthLevel.toInt()}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: warmthLevel,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        activeColor: Colors.orange,
                        onChanged: (value) {
                          warmthLevel = value;
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
                        min: -25,
                        max: 50,
                        divisions: 75,
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

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.opacity, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Fade: ${fadeLevel.toInt()}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: fadeLevel,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          fadeLevel = value;
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
                color: Colors.brown.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: Colors.brown.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.history, color: Colors.brown, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "About Sepia Photography",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Sepia toning was originally a chemical process used to preserve photographs and give them a distinctive warm, brown monochromatic appearance.",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Classic sepia uses warm brown tones",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Deep sepia creates rich, vintage atmosphere",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Light sepia provides subtle nostalgic warmth",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Add grain and vignette for authentic film look",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
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
                      Icon(Icons.tips_and_updates, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Sepia Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Start with moderate intensity and adjust to taste",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Increase warmth for golden vintage effects",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Use higher contrast for dramatic portraits",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Add fade for heavily aged photograph look",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset Sepia",
                    size: bs.md,
                    onPressed: _resetSepiaSettings,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply Sepia",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        ss("Sepia effect applied successfully!");
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

  Color _getSepiaColor() {
    double intensity = sepiaIntensity / 100;
    double warmth = warmthLevel / 100;
    
    if (warmth > 0.7) {
      return Colors.orange[300]!;
    } else if (warmth > 0.4) {
      return Colors.brown[400]!;
    } else {
      return Colors.brown[600]!;
    }
  }
}
